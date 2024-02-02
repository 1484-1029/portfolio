import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

// モデル
class QuestionAnswer {
  final String targetYear;
  final String targetMonth;
  final String questionerName;
  final String answerName;
  final String question;
  final List<dynamic> answers;
  final String sOpenCloesFlg;
  final String sAnswerFlg;
  QuestionAnswer(
    this.targetYear,
    this.targetMonth,
    this.questionerName,
    this.answerName,
    this.question,
    this.answers,
    this.sOpenCloesFlg,
    this.sAnswerFlg,
  );

  String getFormattedAnswers() {
    return answers.join('\n⇩\n'); // 回答を改行で連結
  }
}

void createExcel() async {
  List<QuestionAnswer> questionAnswers = [];
  // エクセル設定
  final Excel excel = Excel.createExcel();
  final Sheet sheet = excel['抽出結果'];
  final CellStyle cellStyle = CellStyle(
    bold: true,
    underline: Underline.Double,
    backgroundColorHex: '#b0c4de',
    fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
    rotation: 0,
    leftBorder: Border(borderStyle: BorderStyle.Thin),
    rightBorder: Border(borderStyle: BorderStyle.Thin),
    topBorder: Border(borderStyle: BorderStyle.Thin),
    bottomBorder: Border(borderStyle: BorderStyle.Thin),
  );

/*---------------------------
 データ抽出
---------------------------*/
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  QuerySnapshot questionSnapshot = await firestore
      .collection('questions')
      // .where('month', isEqualTo: currentMonth)
      .orderBy('dtCreateDate')
      .get();

  for (QueryDocumentSnapshot questionDoc in questionSnapshot.docs) {
    // 質問に関連する回答を取得
    QuerySnapshot answerSnapshot = await firestore
        .collection('answers')
        .where('sQuestionId', isEqualTo: questionDoc.id)
        .orderBy('nRowNumber')
        .get();

    // 質問と回答をリスト化
    DateTime dtCreate = questionDoc['dtCreateDate'].toDate();
    String dtCreateYear = '${dtCreate.year}年';
    String dtCreateMonth = '${dtCreate.month}月';
    String qsName = questionDoc['sQuestionerName'];
    String asName = questionDoc['sAnswerName'];
    String question = questionDoc['sQuestionSentence'];
    String sOpenCloesFlg = questionDoc['sOpenCloesFlg'];
    String sAnswerFlg = questionDoc['sAnswerFlg'];
    List answers = answerSnapshot.docs
        .map((answerDoc) => answerDoc['sAnswerSentence'])
        .toList();

    questionAnswers.add(QuestionAnswer(
      dtCreateYear,
      dtCreateMonth,
      qsName,
      asName,
      question,
      answers,
      sOpenCloesFlg,
      sAnswerFlg,
    ));
  }

  sheet.cell(CellIndex.indexByString("A2")).value = "月";
  sheet.cell(CellIndex.indexByString("B2")).value = "月";
  sheet.cell(CellIndex.indexByString("C2")).value = "社員番号_ 氏名";
  sheet.cell(CellIndex.indexByString("D2")).value = "【質問】質問相手";
  sheet.cell(CellIndex.indexByString("E2")).value = "【質問】質問内容";
  sheet.cell(CellIndex.indexByString("F2")).value = "【質問】回答内容";
  sheet.cell(CellIndex.indexByString("G2")).value = "【質問】事業部会議での共有や相談";
  sheet.cell(CellIndex.indexByString("H2")).value = "ステータス";

  sheet.cell(CellIndex.indexByString("A2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("B2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("C2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("D2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("E2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("F2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("G2")).cellStyle = cellStyle;
  sheet.cell(CellIndex.indexByString("H2")).cellStyle = cellStyle;

  for (var qa in questionAnswers) {
    sheet.appendRow(
      [
        qa.targetYear,
        qa.targetMonth,
        qa.questionerName,
        qa.answerName,
        qa.question,
        qa.getFormattedAnswers(),
        if (qa.sOpenCloesFlg == '1') '希望する' else '',
        if (qa.sAnswerFlg == '1') '回答済み' else '質問中'
      ],
    );

    // sheet.cell().cellStyle = cellStyletext;
  }

  const fileName = '2023_福岡_社員からの疑問・提案.xlsx';
  // 1. Flutter Web
  final List<int>? fileBytes = excel.save(fileName: fileName);

  // Web対応だけなら以降必要なし
  if (!kIsWeb && fileBytes != null) {
    late final String? path;
    if (defaultTargetPlatform == TargetPlatform.android) {
      // 2. Android
      path = '/storage/emulated/0/Download';
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      // 3. iOS
      path = (await getApplicationDocumentsDirectory()).path;
    } else if (defaultTargetPlatform == TargetPlatform.macOS) {
      // 4. macOS
      path = (await getDownloadsDirectory())?.path;
    }
    if (path != null) {
      File('$path/$fileName')
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
  }
}
