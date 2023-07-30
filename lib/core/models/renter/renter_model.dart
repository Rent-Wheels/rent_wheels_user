import 'package:rent_wheels/core/models/cars/cars_model.dart';

class Renter {
  String? id;
  String? userId;
  String? name;
  String? email;
  DateTime? dob;
  String? phoneNumber;
  String? profilePicture;
  String? placeOfResidence;
  List<Car>? cars;

  Renter({
    this.id,
    this.cars,
    this.userId,
    this.name,
    this.email,
    this.dob,
    this.phoneNumber,
    this.profilePicture,
    this.placeOfResidence,
  });

  factory Renter.fromJSON(Map<String, dynamic> json) {
    return Renter(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: DateTime.tryParse(json['dob'] ?? ''),
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
