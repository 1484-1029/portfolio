// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/intrastructure/repository/answer_repository.dart';

// 変数定義
bool isclosed = false;

final detailProviders =
    ChangeNotifierProvider.autoDispose((ref) => DetailQuestionNotifier());

class DetailQuestionNotifier extends ChangeNotifier {
  void setCloseFlg(sQuestionId) {
    isclosed = !isclosed;
    setCloseFlgUpdate(
      sQuestionId,
    );
    notifyListeners();
  }
}

Icon favoriteIcon(sAnswerFlg) {
  if (sAnswerFlg == '1') {
    return const Icon(Icons.star);
  }
  return const Icon(Icons.star_border);
}

void setAnswerFlg(sAnswerFlg) {
  if (sAnswerFlg == '1') {
    isclosed = true;
  } else {
    isclosed = false;
  }
}
