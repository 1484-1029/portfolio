// インポートパッケージ
import 'package:flutter/cupertino.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

/*---------------------------------
 作成中質問破棄ダイアログ
---------------------------------*/
setCansellButton(context) {
  if (controllerText.text != '' ||
      selectedKey != '0' ||
      selectedUser != 'select') {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: const Text('編集を破棄'),
              onPressed: () {
                controllerText.clear();
                selectedKey = '0';
                selectedUser = 'select';
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const HomePage();
                    },
                  ),
                );
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
