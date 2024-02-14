// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/presentation/components/register_input_check.dart';
import 'package:company_question_channel/src/presentation/notifiers/register_employee_notifier.dart';
import 'package:company_question_channel/src/presentation/pages/create_question_page.dart';
import 'package:company_question_channel/src/core/pulldown_map_until.dart';

// インプット情報格納変数
final registEmailController = TextEditingController();
final registPasswordController = TextEditingController();
final registNumberController = TextEditingController();
final registNameSeiController = TextEditingController();
final registNameMeiContriller = TextEditingController();
bool bAuthorCheck = false;

class RegisterEmployeePage extends ConsumerWidget {
  const RegisterEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerEmployeeNotifiers = ref.watch(registerEmployeeNotifier);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('社員登録'),
          backgroundColor: Colors.cyan,
          leading: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              setInitRegist();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 600,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: registEmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Email',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 600,
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: registPasswordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: ' Password',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    width: 600,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('事業所'),
                        DropdownButton<String>(
                          value: sSelectOfficeKey,
                          items: officese.keys.map((String key) {
                            return DropdownMenuItem<String>(
                              value: key,
                              child: Text(officese[key]!),
                            );
                          }).toList(),
                          onChanged: (String? newKey) {
                            registerEmployeeNotifiers.setOfficeValue(newKey);
                          },
                        ),
                      ],
                    )),
                Container(
                  margin: const EdgeInsets.all(5),
                  width: 600,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLines: 1,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: registNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: ' 社員番号',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                Container(
                  width: 610,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: registNameSeiController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: ' 性',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: registNameMeiContriller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: '名',
                              fillColor: Colors.white,
                              filled: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 600,
                  child: ElevatedButton(
                    onPressed: () {
                      // registerUser(context);
                      // Navigator.of(context).pop();
                      registerInputCheck(
                        context,
                        registEmailController.text,
                        registPasswordController.text,
                        sSelectOfficeKey,
                        registNumberController.text,
                        registNameSeiController.text,
                        registNameMeiContriller.text,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan, // ボタンの背景色を設定
                    ),
                    child: const Text('登録'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
