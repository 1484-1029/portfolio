// インポートパッケージ
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// インポートファイル
import 'package:portfolioapp/src/presentation/notifiers/login_notifier.dart';
import 'package:portfolioapp/src/presentation/pages/login_page.dart';

class PasswordField extends ConsumerWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginsProviders = ref.watch(loginNotifiers);

    return TextField(
      keyboardType: TextInputType.text,
      controller: passwordController,
      obscureText: bLookJudge,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: 'Passward',
        fillColor: Colors.white,
        filled: true,
        suffixIcon: IconButton(
          // 文字の表示・非表示でアイコンを変える
          icon: Icon(bLookJudge ? Icons.visibility_off : Icons.visibility),
          // アイコンがタップされたら現在と反対の状態をセットする
          onPressed: () {
            loginsProviders.setChengeLook();
          },
        ),
      ),
      autofillHints: const [AutofillHints.password],
    );
  }
}
