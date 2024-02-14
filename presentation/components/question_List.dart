// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:company_question_channel/src/core/pulldown_map_until.dart';

// インポートファイル
import 'package:company_question_channel/src/domain/entry/question_db/question_db.dart';
import 'package:company_question_channel/src/domain/entry/user_db/user_db.dart';
import 'package:company_question_channel/src/intrastructure/repository/question_repository.dart';
import 'package:company_question_channel/src/intrastructure/repository/user_repository.dart';
import 'package:company_question_channel/src/presentation/components/image_format.dart';
import 'package:company_question_channel/src/presentation/dialogs/question_delete_dialog.dart';
import 'package:company_question_channel/src/presentation/notifiers/bottom_bar_notifier.dart';
import 'package:company_question_channel/src/presentation/pages/detail_question_page.dart';

// 質問ステータス
String questionStatus(sAnswerFlg) {
  String questionStatus = 'チェック依頼中';
  if (sAnswerFlg == '1') {
    questionStatus = '回答済';
  } else {
    questionStatus = '質問中';
  }
  return questionStatus;
}

// 文字色設定
Color questionColor(sAnswerFlg) {
  if (sAnswerFlg == '1') {
    return Colors.green;
  }
  return const Color.fromARGB(255, 245, 120, 111);
}

// 文字数制限
String textContllor(String text, int maxLength) {
  if (text.length <= maxLength) {
    return text;
  } else {
    return '${text.substring(0, maxLength)}...'; // 末尾に省略記号を追加
  }
}

// 質問詳細
Widget questionListView(List<Question> myModels, flg) {
  return Consumer(
    builder: (context, ref, _) {
      // ユーザー全件取得(リアルタイム)
      final userModels = ref.watch(userStreamProvider);

      if (myModels.isEmpty) {
        return const Center(
          child: Text('質問はまだないです'),
        );
      }

      final Map<String, Userinfo> userList = userModels.when(
        data: (data) {
          return {for (var user in data) user.sUserId: user};
        },
        loading: () => {},
        error: (error, stackTrace) => {},
      );

      return ListView.builder(
        itemCount: myModels.length,
        itemBuilder: (BuildContext context, int index) {
          final Question myModel = myModels[index];

          return InkWell(
            onTap: () {
              setQuestionSelected(myModel.sQuestionId);
              setBottomPage(flg);
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetailQuestionPage(
                      sQuestionId: myModel.sQuestionId,
                      sQuestionerId: myModel.sQuestionerId,
                      sQuestioner: myModel.sQuestionerName,
                      sQuestionSentence: myModel.sQuestionSentence,
                      sQuestionerName: myModel.sQuestionerName,
                      sAnswerName: myModel.sAnswerName,
                      sAnswerFlg: myModel.sAnswerFlg,
                      sAnswerId: myModel.sAnswerId,
                      sQuestionerImage: userImageURL(
                          userList[myModel.sQuestionerId]?.sUserImage),
                      sAnswerImage:
                          userImageURL(userList[myModel.sAnswerId]?.sUserImage),
                    );
                  },
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: questionListImageUI(
                    userList[myModel.sQuestionerId]?.sUserImage),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5, right: 5),
                          child: Text(
                            textContllor(
                                '${myModel.sQuestionerName} → ${myModel.sAnswerName}',
                                25),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            retrunCreateDateTime(myModel.dtCreateDate),
                            style: const TextStyle(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        myModel.sQuestionSentence,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Text(
                      questionGenre[myModel.sGenre]!,
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      questionStatus(myModel.sAnswerFlg),
                      style: TextStyle(
                          color: questionColor(myModel.sAnswerFlg),
                          fontSize: 10),
                    ),
                  ],
                ),
                trailing: flg == 2
                    ? IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return questionDeleteDialog(
                                  context, myModel.sQuestionId);
                            },
                          );
                        },
                      )
                    : null,
              ),
            ),
          );
        },
      );
    },
  );
}
