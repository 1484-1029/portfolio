// インポートパッケージ
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// インポートファイル
import 'package:company_question_channel/src/domain/entry/question_db/question_db.dart';
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/bottom_page.dart';
import 'package:company_question_channel/src/presentation/pages/sort/sort_dialog_page.dart';

// データベース設定
final questionsdb = FirebaseFirestore.instance.collection('questions');

//ログイン情報取得
final auth = FirebaseAuth.instance;
String? uid = auth.currentUser?.uid.toString();
String errorM = '';

// 検索文字格納用変数
String searchSentence = '';

//  時間表示
String retrunCreateDateTime(String date) {
  DateTime now = DateTime.now();
  DateTime getDate = DateTime.parse(date);
  int diffDay = now.difference(getDate).inDays;
  int inHours = now.difference(getDate).inHours;
  int inMinutes = now.difference(getDate).inMinutes;
  int inSeconds = now.difference(getDate).inSeconds;
  String formattedDate = DateFormat('yyyy-MM-dd').format(getDate);
  if (diffDay == 0) {
    if (inHours <= 0) {
      if (inMinutes <= 0) {
        return '$inSeconds秒前';
      } else {
        return '$inMinutes分前';
      }
    } else {
      return '$inHours時間前';
    }
  }

  return formattedDate;
}

/*---------------------- 
 ・データ参照処理
----------------------*/
// 1-1.既にチェック済になっている全質問
final allQuestionsStreamProvider = StreamProvider.autoDispose(
  (ref) {
    try {
      if (searchSentence == '') {
        return questionsdb
            .orderBy('dtCreateDate', descending: true)
            .where('sOpenCloesFlg', isEqualTo: '1') // OPEN希望
            .snapshots()
            .map(
              (snapshot) => snapshot.docs
                  .map(
                    (doc) => Question(
                      sQuestionId: doc.id,
                      sGenre: doc.data()['sGenre'],
                      sQuestionerId: doc.data()['sQuestionerId'],
                      sQuestionerName: doc.data()['sQuestionerName'],
                      sAnswerId: doc.data()['sAnswerId'],
                      sAnswerName: doc.data()['sAnswerName'],
                      sQuestionSentence: doc.data()['sQuestionSentence'],
                      sOpenCloesFlg: doc.data()['sOpenCloesFlg'],
                      sAnswerFlg: doc.data()['sAnswerFlg'],
                      dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(doc.data()['dtCreateDate'].toDate())
                          .toString(),
                      sCreateUser: doc.data()['sCreateUser'],
                      dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                          .format(doc.data()['dtUpdateDate'].toDate())
                          .toString(),
                      sUpdateUser: doc.data()['sUpdateUser'],
                    ),
                  )
                  .toList(),
            );
      }
      return questionsdb
          .orderBy('dtCreateDate', descending: true)
          .where('sOpenCloesFlg', isEqualTo: '1') // OPEN希望
          .where('sQuestionSentence', arrayContains: searchSentence)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Question(
                    sQuestionId: doc.id,
                    sGenre: doc.data()['sGenre'],
                    sQuestionerId: doc.data()['sQuestionerId'],
                    sQuestionerName: doc.data()['sQuestionerName'],
                    sAnswerId: doc.data()['sAnswerId'],
                    sAnswerName: doc.data()['sAnswerName'],
                    sQuestionSentence: doc.data()['sQuestionSentence'],
                    sOpenCloesFlg: doc.data()['sOpenCloesFlg'],
                    sAnswerFlg: doc.data()['sAnswerFlg'],
                    dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtCreateDate'].toDate())
                        .toString(),
                    sCreateUser: doc.data()['sCreateUser'],
                    dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtUpdateDate'].toDate())
                        .toString(),
                    sUpdateUser: doc.data()['sUpdateUser'],
                  ),
                )
                .toList(),
          );
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    throw Exception('This is an example exception.');
  },
);

// 2-1.ログインユーザからの質問(全て)
final questionsStreamFromUserProvider = StreamProvider.autoDispose(
  (ref) {
    try {
      return questionsdb
          .orderBy('dtCreateDate', descending: true)
          .where('sQuestionerId', isEqualTo: sUserId) // 質問者がログインユーザ
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Question(
                    sQuestionId: doc.id,
                    sGenre: doc.data()['sGenre'],
                    sQuestionerId: doc.data()['sQuestionerId'],
                    sQuestionerName: doc.data()['sQuestionerName'],
                    sAnswerId: doc.data()['sAnswerId'],
                    sAnswerName: doc.data()['sAnswerName'],
                    sQuestionSentence: doc.data()['sQuestionSentence'],
                    sOpenCloesFlg: doc.data()['sOpenCloesFlg'],
                    sAnswerFlg: doc.data()['sAnswerFlg'],
                    dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtCreateDate'].toDate())
                        .toString(),
                    sCreateUser: doc.data()['sCreateUser'],
                    dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtUpdateDate'].toDate())
                        .toString(),
                    sUpdateUser: doc.data()['sUpdateUser'],
                  ),
                )
                .toList(),
          );
    } catch (e) {
      errorM = e.toString();
      throw Exception('Error fetching data: $e');
    }
  },
);

// 2-2.ログインユーザからの質問(質問が完了していないもの)
final questionsStreamFromUserClearProvider = StreamProvider.autoDispose(
  (ref) {
    try {
      return questionsdb
          .orderBy('dtCreateDate', descending: true)
          .where('sQuestionerId', isEqualTo: sUserId) // 質問者がログインユーザ
          .where('sAnswerFlg', isEqualTo: '0') // 未解決のもの
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Question(
                    sQuestionId: doc.id,
                    sGenre: doc.data()['sGenre'],
                    sQuestionerId: doc.data()['sQuestionerId'],
                    sQuestionerName: doc.data()['sQuestionerName'],
                    sAnswerId: doc.data()['sAnswerId'],
                    sAnswerName: doc.data()['sAnswerName'],
                    sQuestionSentence: doc.data()['sQuestionSentence'],
                    sOpenCloesFlg: doc.data()['sOpenCloesFlg'],
                    sAnswerFlg: doc.data()['sAnswerFlg'],
                    dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtCreateDate'].toDate())
                        .toString(),
                    sCreateUser: doc.data()['sCreateUser'],
                    dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtUpdateDate'].toDate())
                        .toString(),
                    sUpdateUser: doc.data()['sUpdateUser'],
                  ),
                )
                .toList(),
          );
    } catch (e) {
      errorM = e.toString();
      throw Exception('Error fetching data: $e');
    }
  },
);

// 3.ログインユーザへの質問
final questionsStreamToUserProvider = StreamProvider.autoDispose(
  (ref) {
    try {
      return questionsdb
          .orderBy('dtCreateDate', descending: true)
          .where('sAnswerId', isEqualTo: sUserId) // ログインユーザ
          .where('sAnswerFlg', isEqualTo: '0') // 未解決のもの
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Question(
                    sQuestionId: doc.id,
                    sGenre: doc.data()['sGenre'],
                    sQuestionerId: doc.data()['sQuestionerId'],
                    sQuestionerName: doc.data()['sQuestionerName'],
                    sAnswerId: doc.data()['sAnswerId'],
                    sAnswerName: doc.data()['sAnswerName'],
                    sQuestionSentence: doc.data()['sQuestionSentence'],
                    sOpenCloesFlg: doc.data()['sOpenCloesFlg'],
                    sAnswerFlg: doc.data()['sAnswerFlg'],
                    dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtCreateDate'].toDate())
                        .toString(),
                    sCreateUser: doc.data()['sCreateUser'],
                    dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtUpdateDate'].toDate())
                        .toString(),
                    sUpdateUser: doc.data()['sUpdateUser'],
                  ),
                )
                .toList(),
          );
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  },
);

// 4.未チェックの質問
final questionsStreamCheckProvider = StreamProvider.autoDispose(
  (ref) {
    try {
      return questionsdb
          .orderBy('dtCreateDate', descending: true)
          .snapshots()
          .map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Question(
                    sQuestionId: doc.id,
                    sGenre: doc.data()['sGenre'],
                    sQuestionerId: doc.data()['sQuestionerId'],
                    sQuestionerName: doc.data()['sQuestionerName'],
                    sAnswerId: doc.data()['sAnswerId'],
                    sAnswerName: doc.data()['sAnswerName'],
                    sQuestionSentence: doc.data()['sQuestionSentence'],
                    sOpenCloesFlg: doc.data()['sOpenCloesFlg'],
                    sAnswerFlg: doc.data()['sAnswerFlg'],
                    dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtCreateDate'].toDate())
                        .toString(),
                    sCreateUser: doc.data()['sCreateUser'],
                    dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(doc.data()['dtUpdateDate'].toDate())
                        .toString(),
                    sUpdateUser: doc.data()['sUpdateUser'],
                  ),
                )
                .toList(),
          );
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  },
);

/*---------------------- 
 ・データ登録処理
----------------------*/
void addQuestion() {
  try {
    FirebaseFirestore.instance.collection('questions').add(
      {
        'sQuestionerId': sUserId,
        'sGenre': sSelectGenreKey,
        'sQuestionerName': '${sEmployeeNumber}_$sUserNameSei$sUserNameMei',
        'sAnswerId': sSelectedUserNameKey,
        'sAnswerName': sSelectedUserName,
        'sQuestionSentence': controllerText.text,
        'sOpenCloesFlg': bOpenCheck == true ? '1' : '0',
        'sAnswerFlg': '0',
        'dtCreateDate': FieldValue.serverTimestamp(),
        'sCreateUser': '',
        'dtUpdateDate': FieldValue.serverTimestamp(),
        'sUpdateUser': '',
      },
    );
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

/*---------------------- 
 ・データ削除処理
----------------------*/
Future<void> deleteQuestion(String id) async {
  await FirebaseFirestore.instance.collection('questions').doc(id).delete();
}

/*---------------------- 
 ・データ参照処理(条件絞込あり)
----------------------*/
Future<void> setSortSelectData(
  String sKeyword,
  String sQuestionerId,
  String sAnswerId,
  String sGenre,
) async {
  try {
    // 検索結果取得用Listの初期化
    sortQuestions = [];

    // 一時格納List作成
    List<Question> tmpSortQuestions = [];

    // OPEN希望の質問を取得
    Query query = questionsdb
        .orderBy('dtCreateDate')
        .where('sOpenCloesFlg', isEqualTo: '1'); // OPEN希望

    // 質問者を指定している場合、条件追加
    if (sQuestionerId != 'select') {
      query = query.where('sQuestionerId', isEqualTo: sQuestionerId);
    }

    // 回答者を指定している場合、条件追加
    if (sAnswerId != 'select') {
      query = query.where('sAnswerId', isEqualTo: sAnswerId);
    }

    // ジャンルを指定している場合、条件追加
    if (sGenre != 'unSelected') {
      query = query.where('sGenre', isEqualTo: sGenre);
    }

    // ドキュメントの取得
    QuerySnapshot querySnapshot = await query.get();

    // ドキュメントのリストを取得
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    // 一時格納リストに格納
    tmpSortQuestions = documents
        .map((doc) => Question(
              sQuestionId: doc.id,
              sGenre: doc['sGenre'],
              sQuestionerId: doc['sQuestionerId'],
              sQuestionerName: doc['sQuestionerName'],
              sAnswerId: doc['sAnswerId'],
              sAnswerName: doc['sAnswerName'],
              sQuestionSentence: doc['sQuestionSentence'],
              sOpenCloesFlg: doc['sOpenCloesFlg'],
              sAnswerFlg: doc['sAnswerFlg'],
              dtCreateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(doc['dtCreateDate'].toDate())
                  .toString(),
              sCreateUser: doc['sCreateUser'],
              dtUpdateDate: DateFormat('yyyy-MM-dd HH:mm:ss')
                  .format(doc['dtUpdateDate'].toDate())
                  .toString(),
              sUpdateUser: doc['sUpdateUser'],
            ))
        .toList();

    // 検索されたキーワードが部分一致する場合はlistに格納
    for (Question question in tmpSortQuestions) {
      if (sKeyword == '' || question.sQuestionSentence.contains(sKeyword)) {
        sortQuestions.add(question);
      }
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}
