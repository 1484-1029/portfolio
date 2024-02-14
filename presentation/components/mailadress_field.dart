// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:company_question_channel/src/presentation/pages/login_page.dart';

class MailadressField extends ConsumerWidget {
  const MailadressField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      keyboardType: TextInputType.text,
      controller: emailController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Email',
        fillColor: Colors.white,
        filled: true,
      ),
      autofillHints: const [AutofillHints.username],
    );
  }
}
