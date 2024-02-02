// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/user_repository.dart';
import 'package:portfolioapp/src/intrastructure/repository/question_repository.dart';
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/sort/sort_result_page.dart';

class SortDialogPage extends StatefulWidget {
  const SortDialogPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SortDialogScreenState createState() => _SortDialogScreenState();
}

class _SortDialogScreenState extends State<SortDialogPage> {
  @override
  Widget build(BuildContext context) {
    // 　UIの部分はここに書く。
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Container(
          alignment: Alignment.center,
          child: const Text(
            '条件絞り込み',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'キーワード',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                width: double.infinity,
                child: TextField(
                  controller: sortQuestionKeyword,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const Text(
                'ジャンル',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              DropdownButton<String>(
                value: sortGenreKey,
                items: questionGenre.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(questionGenre[key]!),
                  );
                }).toList(),
                onChanged: (String? newKey) {
                  setState(() {
                    sortGenreKey = newKey!;
                    sortGenreName = questionGenre[newKey]!;
                  });
                },
              ),
              const Text(
                '質問者',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              DropdownButton<String>(
                value: sortQuestionerNameKey,
                items: sortUsers.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(sortUsers[key]!),
                  );
                }).toList(),
                onChanged: (String? newKey) {
                  setState(() {
                    sortQuestionerNameKey = newKey!;
                    sortQuestionerName = sortUsers[newKey]!;
                  });
                },
              ),
              const Text(
                '回答者',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
              DropdownButton<String>(
                value: sortAnswerNameKey,
                items: sortUsers.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(sortUsers[key]!),
                  );
                }).toList(),
                onChanged: (String? newKey) {
                  setState(() {
                    sortAnswerNameKey = newKey!;
                    sortAnswerName = sortUsers[newKey]!;
                  });
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  await setSortSelectData(
                    sortQuestionKeyword.text,
                    sortQuestionerNameKey,
                    sortAnswerNameKey,
                    sortGenreKey,
                  );
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const SortResultPage(); // 新しい画面のウィジェットを直接返す
                      },
                    ),
                  );

                  setState(() {
                    // 検索文言初期化
                    sortQuestionKeyword.clear();
                    sortGenreKey = 'unSelected';
                    sortGenreName = '選択してください';
                    sortQuestionerNameKey = 'select';
                    sortQuestionerName = '選択してください';
                    sortAnswerNameKey = 'select';
                    sortAnswerName = '選択してください';
                  });
                },
                child: const Text('検索する'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    // 検索文言初期化
                    sortQuestionKeyword.clear();
                    sortGenreKey = 'unSelected';
                    sortGenreName = '選択してください';
                    sortQuestionerNameKey = 'select';
                    sortQuestionerName = '選択してください';
                    sortAnswerNameKey = 'select';
                    sortAnswerName = '選択してください';
                  });
                },
                child: const Text('閉じる'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
