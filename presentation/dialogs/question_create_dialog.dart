// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:company_question_channel/src/intrastructure/repository/question_repository.dart';
import 'package:company_question_channel/src/presentation/notifiers/create_notifier.dart';
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/bottom_page.dart';

/*-----------------------------------------------
 タイトル：作成質問確認ダイアログ
 ------------------------------------------------
 概要   ：入力した質問内容を表示する
 ------------------------------------------------
 呼出画面：create_question_page.dart(質問作成画面)
 遷移画面：bottom_page.dart(ホーム画面)
------------------------------------------------*/
Widget questionCreateDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Container(
      alignment: Alignment.center,
      child: const Text(
        '内容確認',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    content: SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '質問内容',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text(
                controllerText.text,
              ),
            ),
          ),
          const Text(
            'ジャンル',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              sSelectGenreName,
            ),
          ),
          const Text(
            '事業所名',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              sSelectOffice,
            ),
          ),
          const Text(
            '宛先',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              sSelectedUserName,
            ),
          ),
          const Text(
            '公開の有無',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child:
                bOpenCheck == true ? const Text('公開する') : const Text('公開しない'),
          ),
        ],
      ),
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () async {
              addQuestion();
              setInitCreate();
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const HomePage();
                  },
                ),
              );
            },
            child: const Text('登録する'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ダイアログを閉じる
            },
            child: const Text('閉じる'),
          ),
        ],
      )
    ],
  );
}
