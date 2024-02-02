// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/question_repository.dart';
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

Widget questionCreateDialog(
    BuildContext context, CreateQuestionProvider createQuestionsProviders) {
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
              selectGenreName,
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
              selectOffice,
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
              selectedUserName,
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
