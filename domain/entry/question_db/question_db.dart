import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_db.freezed.dart';
part 'question_db.g.dart';

@freezed
/*----------------------
 questionsコレクション定義
----------------------*/
class Question with _$Question {
  const Question._();
  const factory Question({
    required String sQuestionId,
    required String sGenre,
    required String sQuestionerId,
    required String sQuestionerName,
    required String sAnswerId,
    required String sAnswerName,
    required String sQuestionSentence,
    required String sOpenCloesFlg,
    required String sAnswerFlg,
    required String dtCreateDate,
    required String sCreateUser,
    required String dtUpdateDate,
    required String sUpdateUser,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
