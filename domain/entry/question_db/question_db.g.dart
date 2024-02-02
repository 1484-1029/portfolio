// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_db.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionImpl _$$QuestionImplFromJson(Map<String, dynamic> json) =>
    _$QuestionImpl(
      sQuestionId: json['sQuestionId'] as String,
      sGenre: json['sGenre'] as String,
      sQuestionerId: json['sQuestionerId'] as String,
      sQuestionerName: json['sQuestionerName'] as String,
      sAnswerId: json['sAnswerId'] as String,
      sAnswerName: json['sAnswerName'] as String,
      sQuestionSentence: json['sQuestionSentence'] as String,
      sOpenCloesFlg: json['sOpenCloesFlg'] as String,
      sAnswerFlg: json['sAnswerFlg'] as String,
      dtCreateDate: json['dtCreateDate'] as String,
      sCreateUser: json['sCreateUser'] as String,
      dtUpdateDate: json['dtUpdateDate'] as String,
      sUpdateUser: json['sUpdateUser'] as String,
    );

Map<String, dynamic> _$$QuestionImplToJson(_$QuestionImpl instance) =>
    <String, dynamic>{
      'sQuestionId': instance.sQuestionId,
      'sGenre': instance.sGenre,
      'sQuestionerId': instance.sQuestionerId,
      'sQuestionerName': instance.sQuestionerName,
      'sAnswerId': instance.sAnswerId,
      'sAnswerName': instance.sAnswerName,
      'sQuestionSentence': instance.sQuestionSentence,
      'sOpenCloesFlg': instance.sOpenCloesFlg,
      'sAnswerFlg': instance.sAnswerFlg,
      'dtCreateDate': instance.dtCreateDate,
      'sCreateUser': instance.sCreateUser,
      'dtUpdateDate': instance.dtUpdateDate,
      'sUpdateUser': instance.sUpdateUser,
    };
