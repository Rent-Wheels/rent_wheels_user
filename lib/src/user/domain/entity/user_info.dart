import 'package:equatable/equatable.dart';

class BackendUserInfo extends Equatable {
  final String? id,
      userId,
      name,
      email,
      dob,
      phoneNumber,
      profilePicture,
      placeOfResidence;

  const BackendUserInfo({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.profilePicture,
    required this.placeOfResidence,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        email,
        dob,
        phoneNumber,
        profilePicture,
        placeOfResidence,
      ];
}
