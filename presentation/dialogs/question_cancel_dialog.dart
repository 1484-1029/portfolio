// インポートパッケージ
import 'package:flutter/cupertino.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/pages/create_question_page.dart';

/*-----------------------------------------------
 タイトル：作成中質問破棄ダイアログ
 ------------------------------------------------
 概要   ：質問を作成中に作成キャンセルした場合、
         破棄するかどうか判断する
 ------------------------------------------------
 呼出画面：create_question_page.dart(メニュー画面)
 遷移画面：bottom_page.dart(ホーム画面)
------------------------------------------------*/
setCansellButton(context) {
  if (controllerText.text != '' ||
      sSelectOfficeKey != '0' ||
      sSelectedUserNameKey != 'select') {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('編集を破棄'),
              onPressed: () {
                controllerText.clear();
                sSelectOfficeKey = '0';
                sSelectedUserNameKey = 'select';
                Navigator.pop(context);
                Navigator.pop(context);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: const Text("キャンセル"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
  return Navigator.of(context).pop(true);
}
