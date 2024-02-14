/*---------------------- 
 ・パッケージ・ファイル
----------------------*/
// インポートパッケージ
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/domain/entry/answer_db/answer_db.dart';
import 'package:company_question_channel/src/presentation/notifiers/answer_notifier.dart';
import 'package:company_question_channel/src/presentation/notifiers/bottom_bar_notifier.dart';
import 'package:company_question_channel/src/presentation/notifiers/detail_question_notifier.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/bottom_page.dart';

/*---------------------- 
 ・変数設定
----------------------*/
// データベース設定
final answersdb = FirebaseFirestore.instance.collection('answers');
// 変数定義

/*---------------------- 
 ・データ参照処理
----------------------*/
// 1.質問IDに紐づく回答一覧
final answersStreamProvider = StreamProvider.autoDispose(
  (_) {
    return answersdb
        .where('sQuestionId', isEqualTo: selectQuestionId)
        .orderBy('nRowNumber')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Answer(
                  sAnswerId: doc.id,
                  sAnswerSentence: doc.data()['sAnswerSentence'],
                  sQuestionId: doc.data()['sQuestionId'],
                  sRespondentId: doc.data()['sRespondentId'],
                  nRowNumber: doc.data()['nRowNumber'],
                  dtCreateDate: doc.data()['dtCreateDate'].toString(),
                  sCreateUser: doc.data()['sCreateUser'],
                  dtUpdateDate: doc.data()['dtUpdateDate'].toString(),
                  sUpdateUser: doc.data()['sUpdateUser'],
                ),
              )
              .toList(),
        );
  },
);

/*---------------------- 
 ・連続質問追加処理
----------------------*/
Future<void> addAnswer(
    sQuestionId, sQuestionerId, inputAnswerId, sAnswerContext) async {
  // 最大値格納変数定義
  int nMaxNumber = 0;

  // 最大値データ格納
  final answerdb = await FirebaseFirestore.instance
      .collection('answers')
      .where('sQuestionId', isEqualTo: sQuestionId)
      .orderBy('nRowNumber', descending: true)
      .limit(1)
      .get();

  // 1件でも回答があれば、最大値を変数に格納
  if (answerdb.docs.isNotEmpty) {
    Map<String, dynamic> latestDataMap = answerdb.docs[0].data();
    nMaxNumber = await latestDataMap['nRowNumber'];
  }

  // 回答テーブルに登録する
  await setAddAnswer(
      sQuestionId, sQuestionerId, inputAnswerId, nMaxNumber, sAnswerContext);
}

// 回答追加
Future<void> setAddAnswer(
  sQuestionId,
  sQuestionerId,
  inputAnswerId,
  nMaxNumber,
  sAnswerContext,
) async {
  nMaxNumber += 1;
  await FirebaseFirestore.instance.collection('answers').add(
    {
      'sQuestionId': sQuestionId,
      'sAnswerSentence': answerContext,
      'sRespondentId': sUserId == sQuestionerId ? sQuestionerId : inputAnswerId,
      'nRowNumber': nMaxNumber,
      'dtCreateDate': FieldValue.serverTimestamp(),
      'sCreateUser': '$sUserNameSei $sUserNameMei',
      'dtUpdateDate': FieldValue.serverTimestamp(),
      'sUpdateUser': '$sUserNameSei $sUserNameMei',
    },
  );
}

/*---------------------- 
 ・データ更新処理(チェック者が修正)
----------------------*/
void setCloseFlgUpdate(id) {
  FirebaseFirestore.instance.collection('questions').doc(id).update({
    'sAnswerFlg': isclosed == false ? '0' : '1',
    'dtUpdateDate': FieldValue.serverTimestamp(),
    'sUpdateUser': '$sUserNameSei $sUserNameMei',
  });
}

/*---------------------- 
 ・データ削除
----------------------*/
Future<void> deleteAnswer(String questionId) async {
  await FirebaseFirestore.instance
      .collection('answers')
      .where('sQuestionId', isEqualTo: questionId)
      .get()
      .then((querySnapshot) {
    for (var doc in querySnapshot.docs) {
      doc.reference.delete(); // ドキュメントを削除
    }
  });
}
