// // インポートパッケージ
// import 'package:flutter/material.dart';
// import 'package:portfolioapp/src/presentation/pages/employee/all_employee_page.dart';

// // インポートファイル
// import 'package:portfolioapp/src/presentation/pages/employee/register_employee_page.dart';
// import 'package:portfolioapp/src/presentation/pages/create_question_page.dart';
// import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';
// import 'package:portfolioapp/src/presentation/pages/home_page/mypages/edit_my_page.dart';
// import 'package:portfolioapp/src/presentation/pages/login_page.dart';
// // import 'package:portfolioapp/screens/all_employee_screen.dart';
// // import 'package:portfolioapp/screens/all_questions_screen.dart';
// // import 'package:portfolioapp/screens/bottom_screen.dart';
// // import 'package:portfolioapp/screens/create_question_screen.dart';
// // import 'package:portfolioapp/screens/edit_my_page_screen.dart';
// // import 'package:portfolioapp/screens/login_screen.dart';
// // import 'package:portfolioapp/screens/my_page_screen.dart';
// // import 'package:portfolioapp/screens/my_question_screen.dart';
// // import 'package:portfolioapp/screens/registration_screen.dart';
// // import 'package:portfolioapp/screens/sort_dialog_screen.dart';
// // import 'package:portfolioapp/screens/sort_question_screen.dart';

// class AppRouter {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       // main画面
//       case '/':
//         return MaterialPageRoute(builder: (_) => const LoginPage());
//       // 社員一覧画面
//       case '/AllEmployeePage':
//         return MaterialPageRoute(builder: (_) => const AllEmployeePage());
//       // 全質問一覧(BottomScreen画面)
//       case '/HomePage':
//         return MaterialPageRoute(builder: (_) => const HomePage());
//       // 質問作成画面
//       case '/CreateQuestionPage':
//         return MaterialPageRoute(builder: (_) => const CreateQuestionPage());
//       // ログイン情報修正画面
//       case '/EditMyPage':
//         return MaterialPageRoute(builder: (_) => const EditMyPage());
//       // 社員登録画面
//       case '/RegisterEmployeePage':
//         return MaterialPageRoute(builder: (_) => const RegisterEmployeePage());
//       // 条件絞り込み画面
//       // case '/SortQuestionScreen':
//       //   return MaterialPageRoute(builder: (_) => const SortQuestionScreen());
//       // // 条件絞り込みダイアログ画面
//       // case '/SortDialogScreen':
//       //   return MaterialPageRoute(builder: (_) => const SortDialogScreen());
//       default:
//         return MaterialPageRoute(builder: (_) => const LoginPage());
//     }
//   }
// }
