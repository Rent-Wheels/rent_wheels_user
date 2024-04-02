import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

class BackendUserInfoModel extends BackendUserInfo {
  const BackendUserInfoModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.email,
    required super.dob,
    required super.phoneNumber,
    required super.profilePicture,
    required super.placeOfResidence,
  });

  factory BackendUserInfoModel.fromJSON(Map<String, dynamic> json) {
    return BackendUserInfoModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'name': name,
        'email': email,
        'dob': dob,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'placeOfResidence': placeOfResidence,
      };
}
