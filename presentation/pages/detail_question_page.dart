// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/answer_repository.dart';
import 'package:portfolioapp/src/presentation/components/answer_list.dart';
import 'package:portfolioapp/src/presentation/notifiers/answer_notifier.dart';
import 'package:portfolioapp/src/presentation/notifiers/bottom_bar_notifier.dart';
import 'package:portfolioapp/src/presentation/notifiers/detail_question_notifier.dart';

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
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
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
                                  (selectItem == 2)
                                      ? Container(
                                          alignment: Alignment.topLeft,
                                          width: double.infinity,
                                          margin: const EdgeInsets.all(10),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              detailsProvider
                                                  .setCloseFlg(sQuestionId);
                                            },
                                            icon: isclosed == true
                                                ? const Icon(Icons.star)
                                                : const Icon(Icons.star_border),
                                            label: isclosed == true
                                                ? const Text('解決済み')
                                                : const Text('質問中'),
                                            style: isclosed == true
                                                ? ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Colors.green, // テキスト色
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // 角丸の半径
                                                    ),
                                                  )
                                                : ElevatedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.white,
                                                    backgroundColor:
                                                        Colors.blue, // テキスト色
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), // 角丸の半径
                                                    ),
                                                  ),
                                          ),
                                        )
                                      : Container(),
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
                Container(
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
                            answersProvider.setAnswerContext(); // 文字を変数に格納
                            setMaxNumber(sQuestionId, sQuestionerId, sAnswerId);
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
