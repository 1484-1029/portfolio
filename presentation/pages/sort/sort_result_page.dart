// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/question_repository.dart';
import 'package:portfolioapp/src/presentation/components/question_List.dart';

class SortResultPage extends ConsumerWidget {
  const SortResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('条件絞り込みページ'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.cyan,
        ),
        body: Container(
            margin: const EdgeInsets.all(5),
            child: questionListView(sortQuestions, 1)),
      ),
    );
  }
}
