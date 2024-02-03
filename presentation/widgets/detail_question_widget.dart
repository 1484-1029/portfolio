import 'package:flutter/material.dart';
import 'package:portfolioapp/src/presentation/notifiers/detail_question_notifier.dart';

// テキストフィールド
Widget answerChatTextField(
  answersProvider,
  addAnswerText,
  sQuestionId,
  sQuestionerId,
  sAnswerId,
) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(15),
    width: 500,
    child: TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: null,
      textAlignVertical: TextAlignVertical.center,
      controller: addAnswerText,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            if (addAnswerText.text != '') {
              answersProvider.setAnswerContext(addAnswerText.text); // 文字を変数に格納
              answersProvider.addAnswers(
                  sQuestionId, sQuestionerId, sAnswerId, addAnswerText.text);
              addAnswerText.clear();
            }
          },
          icon: const Icon(Icons.send),
        ),
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(),
      ),
    ),
  );
}

// 解決済み・質問中ボタン
Widget questionStatusButton(detailsProvider, sQuestionId) {
  // 回答済
  if (isclosed == true) {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton.icon(
        onPressed: () {
          detailsProvider.setCloseFlg(sQuestionId);
        },
        icon: const Icon(Icons.star),
        label: const Text('解決済み'),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.green, // テキスト色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // 角丸の半径
          ),
        ),
      ),
    );
  }
  // 未回答・質問中
  return Container(
    alignment: Alignment.topLeft,
    width: double.infinity,
    margin: const EdgeInsets.all(5),
    child: ElevatedButton.icon(
      onPressed: () {
        detailsProvider.setCloseFlg(sQuestionId);
      },
      icon: const Icon(Icons.star_border),
      label: const Text('質問中'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue, // テキスト色
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // 角丸の半径
        ),
      ),
    ),
  );
}
