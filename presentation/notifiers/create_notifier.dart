// インポートパッケージ
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolioapp/src/presentation/pages/create_question_page.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

final createQuestionProviders =
    ChangeNotifierProvider.autoDispose((ref) => CreateQuestionProvider());

class CreateQuestionProvider extends ChangeNotifier {
  void setUserValue(value1, value2) {
    sSelectedUserNameKey = value1;
    sSelectedUserName = value2;
    notifyListeners();
  }

  void setGenreValue(value1, value2) {
    sSelectGenreKey = value1;
    sSelectGenreName = value2;
    notifyListeners();
  }

  void fetchAllUsersAndConvertToMap() async {
    // 初期化処理
    userList = {};
    userList = {'select': '選択してください'};
    sSelectedUserNameKey = 'select';
    sSelectedUserName = '選択してください';

    try {
      if (sSelectOfficeKey != '0') {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('sOfficeId', isEqualTo: sSelectOfficeKey)
            .orderBy('sEmployeeNumber', descending: false)
            .get();
        for (var doc in snapshot.docs) {
          String userId = doc.id;
          String userName = doc['sEmployeeNumber'] +
              '_' +
              doc['sUserNameSei'] +
              doc['sUserNameMei'];
          // 質問者以外のユーザーを抽出
          if (doc['sUserId'] != sUserId) {
            userList[userId] = userName;
          }
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void setOfficeValue(value, value2) {
    sSelectOfficeKey = value;
    sSelectOffice = value2;
    notifyListeners();
  }

  void setOpenCheck(newValue) {
    bOpenCheck = newValue;
    notifyListeners();
  }
}

void setInitCreate() {
  // 初期化処理
  userList = {'select': '選択してください'};
  sSelectOfficeKey = '0';
  sSelectedUserNameKey = 'select';
  sSelectedUserName = '選択してください';
  sSelectGenreKey = 'unSelected';
  sSelectGenreName = '選択してください';
  controllerText.clear();
  bOpenCheck = false;
}
