import 'package:flutter/material.dart';
import 'package:portfolioapp/src/core/util.dart';

// ユーザー画像置換
String userImageURL(String? imgURL) {
  if (imgURL != '') {
    return imgURL.toString();
  } else {
    return defaultImgUrl.toString();
  }
}

// 質問一覧UI
questionListImageUI(imageURL) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: Image.network(
      userImageURL(imageURL),
      width: 50,
      height: 50,
      fit: BoxFit.fill,
    ),
  );
}

// ユーザー一覧UI
userListImageUI(imageURL) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: Image.network(
      userImageURL(imageURL),
      width: 30,
      height: 30,
      fit: BoxFit.fill,
    ),
  );
}

// ユーザー詳細UI
detailUserImageUI(imageURL) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: Image.network(
      userImageURL(imageURL),
      width: 200,
      height: 200,
      fit: BoxFit.fill,
    ),
  );
}
