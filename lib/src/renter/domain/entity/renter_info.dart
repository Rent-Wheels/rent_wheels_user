import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

class RenterInfo extends Equatable {
  final String? id,
      userId,
      name,
      email,
      dob,
      phoneNumber,
      profilePicture,
      placeOfResidence;
  final List<Cars>? cars;

  const RenterInfo({
    required this.id,
    required this.cars,
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
        cars,
      ];
}
