// インポートパッケージ
import 'package:flutter/material.dart';

/*-----------------------------------------------
 タイトル：ログインエラーダイアログ
 ------------------------------------------------
 概要   ：メールアドレスもしくはパスワードが不正の値の場合
         注意のダイアログを表示する
 ------------------------------------------------
 呼出画面：login_page.dart(ログイン画面)
 遷移画面：-
------------------------------------------------*/
void showErrorDialog(BuildContext context, String? message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(message!),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
          ),
        ],
      );
    },
  );
}
