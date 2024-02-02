// インポートパッケージ
import 'package:flutter/material.dart';

//インポートファイル
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';
import 'package:portfolioapp/src/presentation/dialogs/question_create_dialog.dart';

createInputCheck(context, createQuestionsProviders) {
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
  } else if (selectedKey == '0') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '事業所名を選択してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (selectedUser == 'select') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '質問対象者を選択してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (selectGenreKey == 'unSelected') {
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
          child: questionCreateDialog(context, createQuestionsProviders),
        );
      },
    );
  }
}
