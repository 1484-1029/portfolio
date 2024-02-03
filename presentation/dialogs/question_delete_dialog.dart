// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/answer_repository.dart';
import 'package:portfolioapp/src/intrastructure/repository/question_repository.dart';

/*-----------------------------------------------
 タイトル：質問削除ダイアログ
 ------------------------------------------------
 概要   ：不要な質問を削除する場合、表示し、
         消すかどうか判断する
 ------------------------------------------------
 呼出画面：bottom_page.dart(ホーム画面 マイクエスチョン)
 遷移画面：-
------------------------------------------------*/
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
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
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
