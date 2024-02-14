// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/presentation/components/appbar_action.dart';
import 'package:company_question_channel/src/intrastructure/repository/question_repository.dart';
import 'package:company_question_channel/src/presentation/components/drawermenu.dart';
import 'package:company_question_channel/src/presentation/components/question_List.dart';

Tab customTab(String text, badgeCount) {
  final countStr = badgeCount == 0 ? '' : badgeCount.toString();
  return Tab(
    child: RichText(
      text: TextSpan(
        text: '$text ',
        children: [
          TextSpan(
            text: ' $countStr',
            style: TextStyle(
              color: countStr == '' ? Colors.cyan : Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

class MyQuestionPage extends ConsumerWidget {
  const MyQuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myModelsSnapshot1_1 = ref.watch(questionsStreamFromUserProvider);
    final myModelsSnapshot1_2 = ref.watch(questionsStreamFromUserClearProvider);
    final myModelsSnapshot2 = ref.watch(questionsStreamToUserProvider);

    // 各リストの件数取得
    final count1 = myModelsSnapshot1_2.value?.length ?? 0;
    final count2 = myModelsSnapshot2.value?.length ?? 0;
    // final count3 = myModelsSnapshot3.value?.length ?? 0;

    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      // length: 3, // タブの数
      length: 2,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: const Text('MY質問'),
            actions: [notificationsAction(context)],
            bottom: TabBar(
              tabs: <Widget>[
                customTab(
                  '質問',
                  count1,
                ),
                customTab(
                  '回答',
                  count2,
                ),
              ],
            ),
          ),
          drawer: drawerMenu(context),
          body: TabBarView(
            children: <Widget>[
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.all(5),
                child: myModelsSnapshot1_1.when(
                  data: (myModels) {
                    return questionListView(myModels, 2);
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                  error: (error, stackTrace) => SelectableText('Error: $error'),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: myModelsSnapshot2.when(
                  data: (myModels) {
                    return questionListView(myModels, 3);
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  ),
                  error: (error, stackTrace) => SelectableText('Error: $error'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
