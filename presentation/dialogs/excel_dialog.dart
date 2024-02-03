// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/notifiers/excel_notifier.dart';

/*-----------------------------------------------
 タイトル：エクセル出力用ダイアログ
 ------------------------------------------------
 概要   ：過去の登録された質問をエクセルに抽出する
 ------------------------------------------------
 呼出画面：drawermenu.dart(メニュー画面)
 遷移画面：bottom_page.dart(ホーム画面)
------------------------------------------------*/
Widget excelDialog(BuildContext context) {
  return AlertDialog(
    alignment: Alignment.center,
    title: const Text('Excel出力しますか？', textAlign: TextAlign.center),
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
                  createExcel();
                  Navigator.of(context).pop();
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
