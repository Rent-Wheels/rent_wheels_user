import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter_info.dart';

class RenterInfoModel extends RenterInfo {
  const RenterInfoModel({
    required super.id,
    required super.cars,
    required super.userId,
    required super.name,
    required super.email,
    required super.dob,
    required super.phoneNumber,
    required super.profilePicture,
    required super.placeOfResidence,
  });

  factory RenterInfoModel.fromJSON(Map<String, dynamic> json) {
    return RenterInfoModel(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      dob: json['dob'],
      phoneNumber: json['phoneNumber'],
      profilePicture: json['profilePicture'],
      placeOfResidence: json['placeOfResidence'],
      cars: json['cars'].map<CarsModel>((car) => CarsModel.fromJson(car)),
    );
  }
}
