// インポートパッケージ
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

/* 変数定義 */
bool bOpenCheck = false;
final TextEditingController controllerText = TextEditingController();
String selectedKey = '0';
String selectedUser = 'select';
String selectedUserName = '選択してください';
String selectOffice = '選択してください';
Map<String, String> officese = {
  '0': '選択してください',
  '1': '本社',
  '2': '福岡事業所',
};

Map<String, String> questionGenre = {
  'business': '業務関連',
  'technology': '技術関連',
  'humanresources': '人事関連',
  'attendance': '勤怠関連',
  'event': '社内イベント関連',
  'suggestion': '提案',
  'others': 'その他',
  'unSelected': '選択してください',
};

Map<String, String> userList = {'select': '選択してください'};
String selectGenreKey = 'unSelected';
String selectGenreName = '選択してください';

final createQuestionProviders =
    ChangeNotifierProvider.autoDispose((ref) => CreateQuestionProvider());

class CreateQuestionProvider extends ChangeNotifier {
  void setUserValue(value1, value2) {
    selectedUser = value1;
    selectedUserName = value2;
    notifyListeners();
  }

  void setGenreValue(value1, value2) {
    selectGenreKey = value1;
    selectGenreName = value2;
    notifyListeners();
  }

  void fetchAllUsersAndConvertToMap() async {
    // 初期化処理
    userList = {};
    userList = {'select': '選択してください'};
    selectedUser = 'select';
    selectedUserName = '選択してください';

    try {
      if (selectedKey != '0') {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('sOfficeId', isEqualTo: selectedKey)
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
    selectedKey = value;
    selectOffice = value2;
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
  selectedKey = '0';
  selectedUser = 'select';
  selectedUserName = '選択してください';
  selectGenreKey = 'unSelected';
  selectGenreName = '選択してください';
  controllerText.clear();
  bOpenCheck = false;
}
