// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// パスワードの表示・非表示判定(true:非表示,false:表示)
bool bLookJudge = true;

// ログイン画面のNotifierクラス
final loginNotifiers =
    ChangeNotifierProvider.autoDispose((ref) => LoginNotifier());

class LoginNotifier extends ChangeNotifier {
  // パスワードの表示・非表示を切り替えるメソッド
  void setChengeLook() {
    bLookJudge = !bLookJudge;
    notifyListeners();
  }
}
