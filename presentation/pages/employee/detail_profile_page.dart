// インポートパッケージ
import 'package:flutter/material.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/user_repository.dart';
import 'package:portfolioapp/src/presentation/components/image_format.dart';

class DetailProfilePage extends StatelessWidget {
  final String employeeNumber;
  final String userNameSei;
  final String userNameMei;
  final String officeId;
  final String userImage;
  const DetailProfilePage({
    super.key,
    required this.employeeNumber,
    required this.userNameSei,
    required this.userNameMei,
    required this.officeId,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0, // 最初に表示するタブ
      length: 2, // タブの数
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            title: Text('${employeeNumber}_$userNameSei $userNameMei'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    child: detailUserImageUI(userImage),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    width: 250,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: const Icon(
                                Icons.business,
                                size: 20,
                              ),
                            ),
                            const Text('事業所'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(userOffice(officeId)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    width: 250,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: const Icon(
                                Icons.badge,
                                size: 20,
                              ),
                            ),
                            const Text('社員番号'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text(employeeNumber),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(),
                      ),
                    ),
                    width: 250,
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 5),
                              child: const Icon(
                                Icons.face,
                                size: 20,
                              ),
                            ),
                            const Text('氏名'),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: Text('$userNameSei $userNameMei'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
