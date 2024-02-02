import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_db.freezed.dart';
part 'user_db.g.dart';

@freezed
/*----------------------
 usersコレクション定義
----------------------*/
class Userinfo with _$Userinfo {
  const Userinfo._();
  const factory Userinfo({
    required String sUserId,
    required String sEmailAdress,
    required String sUserImage,
    required String sUserNameSei,
    required String sUserNameMei,
    required String sEmployeeNumber,
    required String sOfficeId,
    required String sAuthorityFlg,
    required String sDeviceToken,
    required String dtCreateDate,
    required String sCreateUser,
    required String dtUpdateDate,
    required String sUpdateUser,
  }) = _Userinfo;

  factory Userinfo.fromJson(Map<String, dynamic> json) =>
      _$UserinfoFromJson(json);
}
