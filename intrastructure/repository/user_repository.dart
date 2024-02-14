/*---------------------- 
 ・パッケージ・ファイル
----------------------*/
// インポートパッケージ
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

// インポートファイル
import 'package:company_question_channel/src/domain/entry/user_db/user_db.dart';
import 'package:company_question_channel/src/presentation/notifiers/register_employee_notifier.dart';
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';
import 'package:company_question_channel/src/presentation/pages/employee/register_employee_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/bottom_page.dart';

/*---------------------- 
 ・変数設定
----------------------*/
// データベース設定
final usersdb = FirebaseFirestore.instance.collection('users');

// チェック権限者のリスト
List<String> deviceTokenList = [];

//
Map<String, String> sortUsers = {'select': '選択してください'};

String errorContext1 = '';

/*---------------------- 
 ・ユーザー周りの関数
----------------------*/
// 1.所属事務所判定
String userOffice(flg) {
  if (flg == '1') {
    return '本社';
  }
  if (flg == '2') {
    return '福岡事務所';
  }
  return '無所属';
}

/*---------------------- 
 ・データ参照処理
----------------------*/
// 1.全ユーザのデータ取得
Stream<QuerySnapshot> usersQuestionStreamProvider = FirebaseFirestore.instance
    .collection('users')
    .orderBy('sEmployeeNumber')
    .snapshots();

// 2.ログインユーザのデータ取得
Future<void> getUserInfo(String userId) async {
  try {
    // ログインユーザのドキュメント取得
    final docs = await usersdb.doc(userId).get();

    // データが存在する場合、各変数にログインユーザの情報を格納
    if (docs.exists) {
      sUserId = userId;
      sEmailAdress = docs.data()!['sEmailAdress'];
      sUserNameSei = docs.data()!['sUserNameSei'];
      sUserNameMei = docs.data()!['sUserNameMei'];
      sEmployeeNumber = docs.data()!['sEmployeeNumber'];
      sOfficeId = docs.data()!['sOfficeId'];
      sAuthorityFlg = docs.data()!['sAuthorityFlg'];
      sUserImage = docs.data()!['sUserImage'];
      sDeviceToken = docs.data()!['sDeviceToken'];
    } else {
      // ドキュメントが存在しない場合の処理
      throw Exception('Error fetching data');
    }
  } catch (e) {
    // エラーハンドリング
    throw Exception('Error fetching data: $e');
  }
}

// 3.ユーザー画像更新処理
Future<void> updateImage(userId, editImg) async {
  await FirebaseFirestore.instance.collection('users').doc(userId).update(
    {
      'sUserImage': editImg,
      'dtUpdateDate': FieldValue.serverTimestamp(),
    },
  );
}

// 4.トークン更新(すでに更新されている場合は更新しない)
Future<void> updateToken(userId) async {
  try {
    final fcmToken = await FirebaseMessaging.instance.getToken(
      vapidKey:
          "BC80_umP_tlRPn2DO7bz8BsB8qKErD-mRj9IuSDL6FPpcS4cNlqoY0n5J-fcKT8WrgVI3yjTYCojMMOdim1w0RA",
    );

    // すでにトークンが存在するか確認
    final userDoc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final currentToken = userDoc['sDeviceToken'];

    if (currentToken == null || currentToken != fcmToken) {
      // トークンがまだ存在しないか、新しいトークンが生成されている場合に更新
      await FirebaseFirestore.instance.collection('users').doc(userId).update(
        {
          'sDeviceToken': fcmToken,
          'dtUpdateDate': FieldValue.serverTimestamp(),
        },
      );

      print('トークンが更新されました。');
    } else {
      print('トークンは既に最新です。');
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

// 5.ユーザー画像パス取得
Future<String?> getImageUrl(String imagePath) async {
  // Firebase Storageの参照を作成
  final Reference storageReference =
      FirebaseStorage.instance.ref().child(imagePath);

  // 画像のURLを取得
  final String imageUrl = await storageReference.getDownloadURL();

  return imageUrl;
}

// 6.検索用ユーザー取得
Future<void> setSortSelectUser() async {
  try {
    // ドキュメントの取得
    QuerySnapshot querySnapshot = await usersdb.get();

    // ドキュメントのリストを取得
    List<QueryDocumentSnapshot> documents = querySnapshot.docs;

    // リストに格納
    final sortUserswk = documents
        .map((doc) => Userinfo(
              sUserId: doc.id,
              sEmailAdress: doc['sEmailAdress'],
              sUserImage: doc['sUserImage'],
              sUserNameSei: doc['sUserNameSei'],
              sUserNameMei: doc['sUserNameMei'],
              sEmployeeNumber: doc['sEmployeeNumber'],
              sOfficeId: doc['sOfficeId'],
              sAuthorityFlg: doc['sAuthorityFlg'],
              sDeviceToken: doc['sDeviceToken'],
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

    for (var doc in sortUserswk) {
      String userId = doc.sUserId;
      String userName =
          '${doc.sEmployeeNumber}_${doc.sUserNameSei}${doc.sUserNameMei}';
      sortUsers[userId] = userName;
    }
  } catch (e) {
    throw Exception('Error fetching data: $e');
  }
}

// 7.宛先ユーザートークン取得
Future<String> getAnswertoken(String userId) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  final currentToken = await userDoc['sDeviceToken'];
  return currentToken;
}

// 8.宛先メールアドレス取得
Future<String> getAdress(String userId) async {
  final userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();
  final sEmailAdress = await userDoc['sEmailAdress'];
  return sEmailAdress;
}

// 9.リアルタイムでユーザーを会社ごとに取得(今の所全件取得)
final userStreamProvider = StreamProvider.autoDispose<List<Userinfo>>(
  (ref) {
    final streamController = StreamController<List<Userinfo>>();
    final subscription = usersdb.snapshots().listen(
      (snapshot) {
        final users = snapshot.docs
            .map(
              (doc) => Userinfo(
                sUserId: doc.id,
                sEmailAdress: doc['sEmailAdress'],
                sUserImage: doc['sUserImage'],
                sUserNameSei: doc['sUserNameSei'],
                sUserNameMei: doc['sUserNameMei'],
                sEmployeeNumber: doc['sEmployeeNumber'],
                sOfficeId: doc['sOfficeId'],
                sAuthorityFlg: doc['sAuthorityFlg'],
                sDeviceToken: doc['sDeviceToken'],
                dtCreateDate: doc['dtCreateDate'].toString(),
                sCreateUser: doc['sCreateUser'],
                dtUpdateDate: doc['dtUpdateDate'].toString(),
                sUpdateUser: doc['sUpdateUser'],
              ),
            )
            .toList();
        streamController.add(users);
      },
      onError: (error) {
        print(error);
        streamController.addError(error);
      },
      cancelOnError: true,
    );

    ref.onDispose(() {
      subscription.cancel();
      streamController.close();
    });

    return streamController.stream;
  },
);

// 10.社員登録
Future<void> registerUser(context) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('nEmployeeNumber', isEqualTo: registNumberController.text)
      .get();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // 一つでも入力されていなければ、エラー判定
  if (registEmailController.text == '' ||
      registPasswordController.text == '' ||
      registNumberController.text == '' ||
      registNameSeiController.text == '' ||
      registNameMeiContriller.text == '') {
    errorContext1 = '入力漏れがあります';
  } else {
    final existingUser =
        await auth.fetchSignInMethodsForEmail(registEmailController.text);
    if (existingUser.isNotEmpty) {
      throw PlatformException(
        code: 'ERROR_EMAIL_ALREADY_IN_USE',
        message: 'This email is already registered.',
      );
    }
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: registEmailController.text,
        password: registPasswordController.text,
      );

      final user = userCredential.user;
      final userID = user!.uid;

      if (querySnapshot.docs.isEmpty) {
        FirebaseFirestore.instance.collection('users').doc(userID).set(
          {
            'sUserId': userID,
            'sEmailAdress': registEmailController.text,
            'sUserImage': '',
            'sUserNameSei': registNameSeiController.text,
            'sUserNameMei': registNameMeiContriller.text,
            'sEmployeeNumber': registNumberController.text,
            'sOfficeId': sSelectOfficeKey,
            'sAuthorityFlg': bAuthorCheck == true ? '1' : '0',
            'dtCreateDate': FieldValue.serverTimestamp(),
            'sCreateUser':
                '${registNameSeiController.text} ${registNameMeiContriller.text}',
            'dtUpdateDate': FieldValue.serverTimestamp(),
            // 'sDeviceToken': fcmToken,
            'sDeviceToken': '',
            'sUpdateUser':
                '${registNameSeiController.text} ${registNameMeiContriller.text}',
          },
        );
        setInitRegist();
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {}
      }
    }
  }
}
