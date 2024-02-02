// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/components/image_format.dart';
import 'package:portfolioapp/src/presentation/notifiers/edit_image_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

class EditMyPage extends ConsumerWidget {
  const EditMyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editImagesProviders = ref.watch(editImageNotifier);
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 2, // タブの数
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('ユーザー画像変更ページ'),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const HomePage();
                  },
                ),
              );
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: 250,
                        height: 250,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(),
                        ),
                        child: detailUserImageUI(imageFile),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 246, 217, 251),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            onPressed: () async {
                              await editImagesProviders.getImage();
                            },
                            icon: const Icon(Icons.add_photo_alternate),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    child: const Text('編集完了'),
                    onPressed: () async {
                      await editImagesProviders.editUserImage();
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
