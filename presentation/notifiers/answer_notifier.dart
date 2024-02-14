// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/intrastructure/repository/answer_repository.dart';

// 変数設定
String answerContext = '';

final answerProvider =
    ChangeNotifierProvider.autoDispose((ref) => AnswerProvider());

class AnswerProvider extends ChangeNotifier {
  void setAnswerContext(answer) {
    answerContext = answer;
    notifyListeners();
  }

  // 回答登録
  void addAnswers(id, sQuestionerId, sAnswerId, sAnswerContext) async {
    addAnswer(id, sQuestionerId, sAnswerId, sAnswerContext);
    notifyListeners();
  }
}
