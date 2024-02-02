// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/pages/employee/register_employee_page.dart';
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';

final registerEmployeeNotifier =
    ChangeNotifierProvider.autoDispose((ref) => RegisterEmployeeNotifier());

class RegisterEmployeeNotifier extends ChangeNotifier {
  //
  void setOfficeValue(value) {
    selectedKey = value;
    notifyListeners();
  }
}

void setInitRegist() {
  registEmailController.clear();
  registPasswordController.clear();
  registNumberController.clear();
  registNameSeiController.clear();
  registNameMeiContriller.clear();
  selectedKey = '0';
  selectOffice = '選択してください';
}
