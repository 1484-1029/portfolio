// インポートパッケージ
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/user_repository.dart';
import 'package:portfolioapp/src/presentation/components/image_format.dart';
import 'package:portfolioapp/src/presentation/pages/employee/register_employee_page.dart';
import 'package:portfolioapp/src/presentation/pages/employee/detail_profile_page.dart';

class AllEmployeePage extends ConsumerWidget {
  const AllEmployeePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('社員一覧'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 600,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return const RegisterEmployeePage();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan, // ボタンの背景色を設定
                      ),
                      child: const Text('社員追加'),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: 600,
                      child: StreamBuilder(
                        stream: usersQuestionStreamProvider,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          return StreamBuilder<QuerySnapshot>(
                            stream: usersQuestionStreamProvider,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              List<QueryDocumentSnapshot> documents =
                                  snapshot.data!.docs;
                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: documents.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic>? userData =
                                      documents[index].data()
                                          as Map<String, dynamic>?;

                                  return SingleChildScrollView(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                secondaryAnimation) {
                                              return DetailProfilePage(
                                                employeeNumber:
                                                    userData['sEmployeeNumber'],
                                                userNameSei:
                                                    userData['sUserNameSei'],
                                                userNameMei:
                                                    userData['sUserNameMei'],
                                                userImage:
                                                    userData['sUserImage'],
                                                officeId: userData['sOfficeId'],
                                              );
                                            },
                                          ),
                                        );
                                      },
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                              '${userData!['sEmployeeNumber']}_${userData['sUserNameSei']} ${userData['sUserNameMei']}'),
                                          leading: userListImageUI(
                                              userData['sUserImage']),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
