// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/presentation/components/appbar_action.dart';
import 'package:company_question_channel/src/intrastructure/repository/question_repository.dart';
import 'package:company_question_channel/src/presentation/components/drawermenu.dart';
import 'package:company_question_channel/src/presentation/components/question_List.dart';

class AllQuestionsPage extends ConsumerWidget {
  const AllQuestionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allQuestionModelsSnapshot = ref.watch(allQuestionsStreamProvider);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('質問一覧ページ'),
          actions: [notificationsAction(context)],
          backgroundColor: Colors.cyan,
        ),
        drawer: drawerMenu(context),
        body: Container(
          margin: const EdgeInsets.all(5),
          child: allQuestionModelsSnapshot.when(
            data: (myModels) {
              return questionListView(myModels.isEmpty ? [] : myModels, 0);
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
      ),
    );
  }
}
