// インポートパッケージ
import 'package:flutter/material.dart';

//インポートファイル
import 'package:company_question_channel/src/presentation/dialogs/question_create_dialog.dart';
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';

/*-----------------------------------------------
 タイトル：引数チェックコンポーネント
 ------------------------------------------------
 概要   ：下記項目の入力に不正(未入力など)がないかチェックする
         もし不正があった場合、SnackBarで告知する。
         ・質問内容
         ・事業所名
         ・質問相手
         ・ジャンル
 ------------------------------------------------
 呼出画面：create_question_page.dart(質問作成画面)
 遷移画面：-
------------------------------------------------*/
createInputCheck(context) {
  if (controllerText.text == '') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '質問内容を入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (sSelectOfficeKey == '0') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '事業所名を選択してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (sSelectedUserName == 'select') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '質問対象者を選択してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (sSelectGenreKey == 'unSelected') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'ジャンルを選択してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: questionCreateDialog(context),
        );
      },
    );
  }
}
