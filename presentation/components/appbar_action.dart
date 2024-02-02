// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/pages/create_question_page.dart';

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
