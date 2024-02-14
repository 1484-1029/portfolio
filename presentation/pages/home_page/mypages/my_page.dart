// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/intrastructure/repository/user_repository.dart';
import 'package:company_question_channel/src/presentation/components/drawermenu.dart';
import 'package:company_question_channel/src/presentation/components/image_format.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/bottom_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/mypages/edit_my_page.dart';

class MyPage extends ConsumerWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 2, // タブの数
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: const Text('マイページ'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const EditMyPage();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit))
            ],
          ),
          drawer: drawerMenu(context),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    child: detailUserImageUI(sUserImage.toString()),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    width: 250,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: const Icon(
                                Icons.business,
                                size: 20,
                              ),
                            ),
                            const Text('事業所'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(userOffice(sOfficeId)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    width: 250,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: const Icon(
                                Icons.badge,
                                size: 20,
                              ),
                            ),
                            const Text('社員番号'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(sEmployeeNumber),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    width: 250,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: const Icon(
                                Icons.face,
                                size: 20,
                              ),
                            ),
                            const Text('氏名'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text('$sUserNameSei $sUserNameMei'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
