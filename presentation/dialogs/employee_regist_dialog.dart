// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/question_repository.dart';
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/employee/register_employee_page.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

/*-----------------------------------------------
 タイトル：社員登録ダイアログ
 ------------------------------------------------
 概要   ：入力した社員情報内容を表示し、
         問題なければデータベースに登録する
 ------------------------------------------------
 呼出画面：register_employee_page.dart(社員登録画面)
 遷移画面：all_employee_page.dart.dart(社員一覧画面)
------------------------------------------------*/
Widget employeeRegistDialog(BuildContext context) {
  String email = registEmailController.text;
  String name =
      '${registNameSeiController.text} ${registNameMeiContriller.text}';
  String number = registNumberController.text;
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    title: Container(
      alignment: Alignment.center,
      child: const Text(
        '登録内容確認',
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
            'メールアドレス',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              email,
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
            '社員番号',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              number,
            ),
          ),
          const Text(
            'ユーザー名',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Text(
              name,
            ),
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
