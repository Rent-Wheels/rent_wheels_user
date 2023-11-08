import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

class UserInfoModel extends UserInfo {
  UserInfoModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.email,
    required super.dob,
    required super.phoneNumber,
    required super.profilePicture,
    required super.placeOfResidence,
  });

  factory UserInfoModel.fromJSON(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
    );
  }
}
