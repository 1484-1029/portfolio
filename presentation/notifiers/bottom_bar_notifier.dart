// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 変数設定
int selectItem = 0; // homepageのbottomバー用
String selectQuestionId = ''; // 選択した質問ID格納用変数

final bottomSelectProviders =
    ChangeNotifierProvider.autoDispose((ref) => BottomSelectNotifier());

// provider定義
class BottomSelectNotifier extends ChangeNotifier {
  void selectBottomPage(pageNo) {
    setBottomPage(pageNo);
    notifyListeners();
  }
}

// 選択ページ設定(bottombar)
void setBottomPage(int page) {
  selectItem = page;
}

// 選択した質問の質問IDを取得
void setQuestionSelected(String value) {
  selectQuestionId = value;
}
