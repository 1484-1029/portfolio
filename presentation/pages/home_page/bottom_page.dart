// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/intrastructure/repository/question_repository.dart';
import 'package:company_question_channel/src/presentation/notifiers/bottom_bar_notifier.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/allquestions_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/my_question_page.dart';
import 'package:company_question_channel/src/presentation/pages/home_page/mypages/my_page.dart';

// ログインユーザ情報格納用変数
String sUserId = '';
String sEmailAdress = '';
String sUserImage = '';
String sUserNameSei = '';
String sUserNameMei = '';
String sEmployeeNumber = '';
String sOfficeId = '';
String sAuthorityFlg = '';
String sDeviceToken = '';

// アイコンに通知があるかないかを判断
BottomNavigationBarItem buildNavigationBarItem(
    IconData icon, String label, int count1, int count2) {
  return BottomNavigationBarItem(
    icon: Stack(
      children: [
        Icon(icon),
        if (count1 > 0 || count2 > 0)
          Positioned(
            right: 0,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minWidth: 8,
                minHeight: 8,
              ),
            ),
          ),
      ],
    ),
    label: label,
  );
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 質問データ取得
    final myModelsSnapshot1 = ref.watch(questionsStreamFromUserClearProvider);
    final myModelsSnapshot2 = ref.watch(questionsStreamToUserProvider);
    final bottomSelectsProviders = ref.watch(bottomSelectProviders);

    // 件数取得
    int cont1 = 0;
    int cont2 = 0;

    // もし自分の完了していない質問が存在する場合、件数を格納する
    if (myModelsSnapshot1.value != null &&
        myModelsSnapshot1.value!.isNotEmpty) {
      cont1 = myModelsSnapshot1.value!.length;
    }

    // もし自分宛の質問が存在する場合、件数を格納する
    if (myModelsSnapshot2.value != null &&
        myModelsSnapshot2.value!.isNotEmpty) {
      cont2 = myModelsSnapshot2.value!.length;
    }

    // ページ
    final tabs = <Widget>[
      const AllQuestionsPage(),
      const MyQuestionPage(),
      const MyPage(),
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Center(
          child: tabs.elementAt(selectItem),
        ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'リスト',
              ),
              buildNavigationBarItem(
                Icons.quiz,
                'MyQ',
                cont1,
                cont2,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'マイページ',
              ),
            ],
            currentIndex: selectItem,
            backgroundColor: Colors.grey[100],
            selectedItemColor: Colors.cyan,
            onTap: (index) {
              bottomSelectsProviders.selectBottomPage(index);
            },
          ),
        ),
      ),
    );
  }
}
