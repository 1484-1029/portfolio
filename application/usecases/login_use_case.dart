// インポートパッケージ
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/core/util.dart';
import 'package:portfolioapp/src/intrastructure/repository/user_repository.dart';
import 'package:portfolioapp/src/presentation/dialogs/error_dialog.dart';
import 'package:portfolioapp/src/presentation/notifiers/bottom_bar_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';
import 'package:portfolioapp/src/presentation/pages/login_page.dart';

/*---------------------- 
 ・ログイン機能
----------------------*/
Future<void> login(context) async {
  // メールアドレスとパスワードを取得
  String email = emailController.text;
  String password = passwordController.text;

  // ログイン処理実施
  try {
    // 1.ログイン処理
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 2.ログインユーザーのユーザーIDを取得
    final FirebaseAuth auth = FirebaseAuth.instance;
    final userID = auth.currentUser!.uid;

    // 3.ログイン情報を変数に格納
    await getUserInfo(userID);

    // 4.遷移先のbottombarのページ設定(ログイン後は質問一覧ページに設定)
    setBottomPage(0);

    // 5.全質問一覧ページ(all_questions_screen)へ遷移
    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const HomePage();
        },
      ),
    );

    // メールアドレス・パスワード変数の初期化
    emailController.clear();
    passwordController.clear();
  } on FirebaseAuthException catch (e) {
    // エラーハンドリング設定
    final message = handleException(e);
    showErrorDialog(context, message);
  }
}
