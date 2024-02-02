// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/answer_repository.dart';

// 変数設定
String answerContext = '';

final answerProvider =
    ChangeNotifierProvider.autoDispose((ref) => AnswerProvider());

class AnswerProvider extends ChangeNotifier {
  void setAnswerContext() {
    answerContext = addAnswerText.text;
    notifyListeners();
  }

  void addAnswers(id, sQuestionerId, sAnswerId) {
    setAddAnswer(id, sQuestionerId, sAnswerId);
    notifyListeners();
  }
}
