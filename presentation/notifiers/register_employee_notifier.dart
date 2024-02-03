// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/pages/employee/register_employee_page.dart';
import 'package:portfolioapp/src/presentation/pages/create_question_page.dart';

final registerEmployeeNotifier =
    ChangeNotifierProvider.autoDispose((ref) => RegisterEmployeeNotifier());

class RegisterEmployeeNotifier extends ChangeNotifier {
  void setOfficeValue(value) {
    sSelectOfficeKey = value;
    notifyListeners();
  }
}

void setInitRegist() {
  registEmailController.clear();
  registPasswordController.clear();
  registNumberController.clear();
  registNameSeiController.clear();
  registNameMeiContriller.clear();
  sSelectOfficeKey = '0';
  sSelectOffice = '選択してください';
}
