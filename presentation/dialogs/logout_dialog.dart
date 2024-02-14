// インポートパッケージ
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// インポートファイル
import 'package:company_question_channel/main.dart';

/*-----------------------------------------------
 タイトル：ログアウト用ダイアログ
 ------------------------------------------------
 概要   ：ログアウトする
 ------------------------------------------------
 呼出画面：drawermenu.dart(メニュー画面)
 遷移画面：login_page.dart(ログイン画面)
------------------------------------------------*/
Widget logoutDialog(BuildContext context) {
  return AlertDialog(
    alignment: Alignment.center,
    title: const Text('ログアウトしますか？', textAlign: TextAlign.center),
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
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const MyApp();
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
