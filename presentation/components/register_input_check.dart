// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/dialogs/employee_regist_dialog.dart';

registerInputCheck(
  context,
  email,
  password,
  officeflg,
  emploeeNo,
  nameSei,
  nameMei,
) {
  if (email == '') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'メールアドレスを入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (password == '0') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          'パスワードを入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (officeflg == '0') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '事業所名を選択してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (emploeeNo == '') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '社員番号を入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (nameSei == 'unSelected') {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          '名字を入力してください',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  } else if (nameMei == 'unSelected') {
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
