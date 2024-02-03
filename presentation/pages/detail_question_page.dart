// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/answer_repository.dart';
import 'package:portfolioapp/src/presentation/components/answer_list.dart';
import 'package:portfolioapp/src/presentation/components/image_format.dart';
import 'package:portfolioapp/src/presentation/notifiers/answer_notifier.dart';
import 'package:portfolioapp/src/presentation/notifiers/bottom_bar_notifier.dart';
import 'package:portfolioapp/src/presentation/notifiers/detail_question_notifier.dart';
import 'package:portfolioapp/src/presentation/widgets/detail_question_widget.dart';

// アンサー格納変数
TextEditingController addAnswerText = TextEditingController();

class DetailQuestionPage extends ConsumerWidget {
  const DetailQuestionPage({
    super.key,
    required this.sQuestionId,
    required this.sQuestionerId,
    required this.sQuestioner,
    required this.sQuestionSentence,
    required this.sQuestionerName,
    required this.sAnswerName,
    required this.sAnswerFlg,
    required this.sAnswerId,
    required this.sQuestionerImage,
    required this.sAnswerImage,
  });

  final String sQuestionId;
  final String sQuestionerId;
  final String sQuestionSentence;
  final String sQuestioner;
  final String sQuestionerName;
  final String sAnswerName;
  final String sAnswerFlg;
  final String sAnswerId;
  final String sQuestionerImage;
  final String sAnswerImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 一番最初の時だけ、引数を格納する
    final myModelsSnapshot = ref.watch(answersStreamProvider);
    final answersProvider = ref.watch(answerProvider);
    final detailsProvider = ref.watch(detailProviders);

    if (selectItem == 2) {
      return DefaultTabController(
        initialIndex: 0, // 最初に表示するタブ
        length: 2, // タブの数
        child: WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.cyan,
                title: const Text('詳細ページ'),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.all(10),
                              width: 600,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                          '$sQuestionerNameさん ⇨ $sAnswerNameさんへ質問'),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Row(
                                        children: [
                                          userListImageUI(sQuestionerImage),
                                          Flexible(
                                            child: Text(
                                              sQuestionSentence,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 10,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    questionStatusButton(
                                        detailsProvider, sQuestionId),
                                    const Divider(
                                      color: Colors.grey, // 線の色を指定
                                      thickness: 1.0, // 線の太さを指定
                                      height: 1.0, // 線の高さを指定
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 500,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topRight,
                                              child: myModelsSnapshot.when(
                                                data: (myModels) {
                                                  return answerListView(
                                                    myModels,
                                                    sQuestionerId,
                                                    sQuestionerImage,
                                                    sAnswerImage,
                                                    sQuestionerName,
                                                    sAnswerName,
                                                  );
                                                },
                                                loading: () => const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.0,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(Colors.red),
                                                  ),
                                                ),
                                                error: (error, stackTrace) =>
                                                    SelectableText(
                                                        'Error: $error'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  answerChatTextField(
                    answersProvider,
                    addAnswerText,
                    sQuestionId,
                    sQuestionerId,
                    sAnswerId,
                  )
                ],
              ),
              resizeToAvoidBottomInset: true,
            ),
          ),
        ),
      );
    }

    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 2, // タブの数
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.cyan,
              title: const Text('詳細ページ'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topCenter,
                            margin: const EdgeInsets.all(10),
                            width: 600,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                        '$sQuestionerNameさん ⇨ $sAnswerNameさんへ質問'),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        userListImageUI(sQuestionerImage),
                                        Flexible(
                                          child: Text(
                                            sQuestionSentence,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 10,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    color: Colors.grey, // 線の色を指定
                                    thickness: 1.0, // 線の太さを指定
                                    height: 1.0, // 線の高さを指定
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: 500,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            child: myModelsSnapshot.when(
                                              data: (myModels) {
                                                return answerListView(
                                                  myModels,
                                                  sQuestionerId,
                                                  sQuestionerImage,
                                                  sAnswerImage,
                                                  sQuestionerName,
                                                  sAnswerName,
                                                );
                                              },
                                              loading: () => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.red),
                                                ),
                                              ),
                                              error: (error, stackTrace) =>
                                                  SelectableText(
                                                      'Error: $error'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                answerChatTextField(
                  answersProvider,
                  addAnswerText,
                  sQuestionId,
                  sQuestionerId,
                  sAnswerId,
                )
              ],
            ),
            resizeToAvoidBottomInset: true,
          ),
        ),
      ),
    );
  }
}
