// インポートパッケージ
import 'package:firebase_auth/firebase_auth.dart';

/*---------------------- 
 ・ログアウト機能
 ----------------------*/
void logput() {
  FirebaseAuth.instance.signOut();
}
