// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';

/*-----------------------------------------------
 タイトル：appbarコンポーネント
 ------------------------------------------------
 概要   ：appbarを定義する
 ------------------------------------------------
 呼出画面：bottom_page.dart(ホーム画面)
 遷移画面：-
------------------------------------------------*/
Row notificationsAction(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        icon: const Icon(Icons.maps_ugc),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return const CreateQuestionPage();
              },
            ),
          );
        },
      ),
    ],
  );
}
