import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

class Renter extends Equatable {
  final String? id,
      dob,
      name,
      email,
      userId,
      phoneNumber,
      profilePicture,
      placeOfResidence;
  final List<Car>? cars;

  const Renter({
    required this.id,
    required this.dob,
    required this.cars,
    required this.name,
    required this.email,
    required this.userId,
    required this.phoneNumber,
    required this.profilePicture,
    required this.placeOfResidence,
  });

  @override
  List<Object?> get props => [
        id,
        dob,
        name,
        cars,
        email,
        userId,
        phoneNumber,
        profilePicture,
        placeOfResidence,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'dob': dob,
        'name': name,
        'email': email,
        'userId': userId,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
        'placeOfResidence': placeOfResidence,
        'cars': cars?.map<Map<String, dynamic>>((e) => e.toMap()).toList(),
      };
}
