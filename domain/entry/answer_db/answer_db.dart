import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer_db.freezed.dart';
part 'answer_db.g.dart';

@freezed
/*----------------------
 answersコレクション定義
----------------------*/
class Answer with _$Answer {
  const Answer._();
  const factory Answer({
    required String sAnswerId,
    required String sRespondentId,
    required String sQuestionId,
    required String sAnswerSentence,
    required int nRowNumber,
    required String dtCreateDate,
    required String sCreateUser,
    required String dtUpdateDate,
    required String sUpdateUser,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
