// インポートパッケージ
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/components/create_input_check.dart';
import 'package:portfolioapp/src/presentation/dialogs/question_cancel_dialog.dart';
import 'package:portfolioapp/src/presentation/notifiers/create_notifier.dart';

class CreateQuestionPage extends ConsumerWidget {
  const CreateQuestionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createQuestionsProviders = ref.watch(createQuestionProviders);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text('質問作成ページ'),
          leading: IconButton(
            onPressed: () {
              setCansellButton(context);
            },
            icon: const Icon(Icons.clear),
          ),
        ),
        body: Center(
          child: Container(
              alignment: Alignment.topCenter,
              margin: const EdgeInsets.all(10),
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '質問内容',
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      width: double.infinity,
                      child: TextFormField(
                        controller: controllerText,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: const Text('ジャンル'),
                      trailing: DropdownButton<String>(
                        value: selectGenreKey,
                        items: questionGenre.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(questionGenre[key]!),
                          );
                        }).toList(),
                        onChanged: (String? newKey) {
                          createQuestionsProviders.setGenreValue(
                              newKey, questionGenre[newKey]!);
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('事業所'),
                      trailing: DropdownButton<String>(
                        value: selectedKey,
                        items: officese.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(officese[key]!),
                          );
                        }).toList(),
                        onChanged: (String? newKey) {
                          createQuestionsProviders.setOfficeValue(
                              newKey, officese[newKey]!);
                          createQuestionsProviders
                              .fetchAllUsersAndConvertToMap();
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('宛先'),
                      trailing: DropdownButton<String>(
                        value: selectedUser,
                        items: userList.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(userList[key]!),
                          );
                        }).toList(),
                        onChanged: (String? newKey) {
                          createQuestionsProviders.setUserValue(
                              newKey, userList[newKey]!);
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('公開する'),
                      trailing: CupertinoSwitch(
                        value: bOpenCheck,
                        onChanged: (bool newValue) {
                          createQuestionsProviders.setOpenCheck(newValue);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                      ),
                      onPressed: () {
                        createInputCheck(context, createQuestionsProviders);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.all(5),
                        width: 400,
                        child: const Text('質問する'),
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
