// インポートパッケージ
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';

// インポートファイル
import 'package:portfolioapp/src/intrastructure/repository/user_repository.dart';
import 'package:portfolioapp/src/presentation/pages/home_page/bottom_page.dart';

// アップロード画像URL格納
String selectedImageUrl = '';
final picker = ImagePicker();
Uint8List? imageFile;
String imgUrl = '';

final editImageNotifier =
    ChangeNotifierProvider.autoDispose((ref) => EditImageNotifier());

class EditImageNotifier extends ChangeNotifier {
  // web用
  // 画像取得処理
  Future getImage() async {
    try {
      Uint8List? uint8list = await ImagePickerWeb.getImageAsBytes();
      if (uint8list != null) {
        imageFile = uint8list;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  // 画像アップロード
  Future editUserImage() async {
    // 画像が選択されている場合、storageにアップロードする
    try {
      // 画像が選択されている場合、storageにアップロードする
      if (imageFile != null) {
        var metadata = SettableMetadata(
          contentType: "image/jpeg",
        );

        // 画像のパス設定
        final storageRef = FirebaseStorage.instance.ref("users/$sUserId");

        // 画像をStorageにアップロード
        await storageRef.putData(imageFile!, metadata);

        // アップロードした画像のURLを取得
        imgUrl = await storageRef.getDownloadURL();

        // firestoreに追加
        await updateImage(sUserId, imgUrl);
        sUserImage = imgUrl;
      }

      // ユーザーを登録する処理
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
