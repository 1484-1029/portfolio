// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:company_question_channel/src/domain/entry/answer_db/answer_db.dart';

// 1質問に対しての回答一覧
Widget answerListView(
  List<Answer> myModels,
  String sQuestionerId,
  String sQuestionerImage,
  String sAnswerImage,
  String sQuestionerName,
  String sAnswerName,
) {
  double maxWidthvalue = 250.0;
  // 回答がない場合は「未回答を表示」
  if (myModels.isEmpty) {
    return Container(
      alignment: Alignment.center,
      child: const SelectableText('未回答'),
    );
    // チェック画面には回答は不要
  }
  // 回答一覧を表示
  return ListView.builder(
    itemCount: myModels.length,
    itemBuilder: (BuildContext context, int index) {
      final Answer myModel = myModels[index];

      // 回答者がログインユーザの場合、左よせする
      if (sQuestionerId != myModel.sRespondentId) {
        return Container(
            margin: const EdgeInsets.only(top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: SelectableText(
                    sAnswerName,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxWidthvalue,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 130, 255, 130),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 10,
                            myModel.sAnswerSentence,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(200),
                      child: Image.network(
                        sAnswerImage,
                        width: 30,
                        height: 30,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
              ],
            ));
      }
      // 回答者がログインユーザ意外の場合、右よせする
      return Container(
          margin: const EdgeInsets.only(top: 10, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                child: SelectableText(
                  sQuestionerName,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Image.network(
                      sQuestionerImage,
                      width: 30,
                      height: 30,
                      fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: maxWidthvalue,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 170, 170, 170),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                          myModel.sAnswerSentence,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ));
    },
  );
}
