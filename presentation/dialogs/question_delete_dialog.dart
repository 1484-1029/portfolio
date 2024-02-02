/*---------------------------------
 質問削除ダイアログ
---------------------------------*/
// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/answer_repository.dart';
import 'package:portfolioapp/src/intrastructure/repository/question_repository.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

Widget questionDeleteDialog(BuildContext context, questionId) {
  return AlertDialog(
    alignment: Alignment.center,
    title: const Text('質問を削除しますか？', textAlign: TextAlign.center),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  deleteQuestion(questionId);
                  deleteAnswer(questionId);
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: const Text(
                  'はい',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(5),
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'いいえ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  );
}
