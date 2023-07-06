import 'package:rent_wheels/core/models/cars/cars_model.dart';

class Renter {
  String userId;
  String name;
  String email;
  DateTime dob;
  String phoneNumber;
  String profilePicture;
  String placeOfResidence;
  List<Car>? cars;

  Renter({
    this.cars,
    required this.userId,
    required this.name,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.profilePicture,
    required this.placeOfResidence,
  });

  factory Renter.fromJSON(Map<String, dynamic> json) {
    return Renter(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: DateTime.parse(json['dob']),
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
      cars: json['cars'] == null
          ? null
          : List<Car>.from(
              json['cars'].map(
                (car) => Car.fromJSON(car),
              ),
            ),
    );
  }
}
