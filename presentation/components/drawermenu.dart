// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:company_question_channel/src/intrastructure/repository/user_repository.dart';

// インポートファイル
import 'package:company_question_channel/src/presentation/dialogs/excel_dialog.dart';
import 'package:company_question_channel/src/presentation/dialogs/logout_dialog.dart';
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';
import 'package:company_question_channel/src/presentation/pages/employee/all_employee_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/bottom_page.dart';
import 'package:company_question_channel/src/presentation/pages/sort/sort_dialog_page.dart';

// メニュー内容
Drawer drawerMenu(context) {
  return Drawer(
    // width: 200,
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(
          height: 110,
          child: DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.cyan,
            ),
            child: Text(
              '${sEmployeeNumber}_$sUserNameSei $sUserNameMei',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.search),
              SizedBox(
                width: 10,
              ),
              Text('検索する'),
            ],
          ),
          onTap: () async {
            await setSortSelectUser();
            await showDialog(
              context: context,
              builder: (BuildContext context) {
                return const SortDialogPage();
              },
            );
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.create),
              SizedBox(
                width: 10,
              ),
              Text('質問する'),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const CreateQuestionPage();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.people),
              SizedBox(
                width: 10,
              ),
              Text('社員一覧'),
            ],
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const AllEmployeePage();
                },
              ),
            );
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.description),
              SizedBox(
                width: 10,
              ),
              Text('Excel出力'),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return excelDialog(context);
              },
            );
          },
        ),
        ListTile(
          title: const Row(
            children: [
              Icon(Icons.logout_sharp),
              SizedBox(
                width: 10,
              ),
              Text('ログアウト'),
            ],
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return logoutDialog(context);
              },
            );
          },
        ),
      ],
    ),
  );
}
