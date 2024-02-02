// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/employee/register_employee_page.dart';
import 'package:portfolioapp/src/presentation/dialogs/employee_regist_dialog.dart';

registerInputCheck(context) {
  if (registEmailController.text == '') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'メールアドレスを入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (registPasswordController.text == '0') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'パスワードを入力してください',
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
  } else if (registNameSeiController.text == '') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '社員番号を入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (registNameSeiController.text == 'unSelected') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '名字を入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (registNameMeiContriller.text == 'unSelected') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '名前を入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: employeeRegistDialog(context),
        );
      },
    );
  }
}
