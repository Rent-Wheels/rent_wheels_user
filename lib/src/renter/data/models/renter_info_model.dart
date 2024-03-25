import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter_info.dart';

class RenterInfoModel extends RenterInfo {
  const RenterInfoModel({
    required super.id,
    required super.dob,
    required super.cars,
    required super.name,
    required super.email,
    required super.userId,
    required super.phoneNumber,
    required super.profilePicture,
    required super.placeOfResidence,
  });

  factory RenterInfoModel.fromJSON(Map<String, dynamic>? json) {
    return RenterInfoModel(
      id: json?['id'],
      dob: json?['dob'],
      name: json?['name'],
      email: json?['email'],
      userId: json?['userId'],
      phoneNumber: json?['phoneNumber'],
      profilePicture: json?['profilePicture'],
      placeOfResidence: json?['placeOfResidence'],
      cars: json?['cars']
          .map<CarsModel>((car) => CarsModel.fromJSON(car))
          .toList(),
    );
  }
}
