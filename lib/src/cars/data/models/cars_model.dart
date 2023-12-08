import 'package:rent_wheels/src/cars/domain/entity/car_media.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

class CarsModel extends Cars {
  const CarsModel({
    required super.id,
    required super.rate,
    required super.make,
    required super.type,
    required super.plan,
    required super.model,
    required super.color,
    required super.terms,
    required super.media,
    required super.ownerId,
    required super.capacity,
    required super.location,
    required super.condition,
    required super.description,
    required super.maxDuration,
    required super.durationUnit,
    required super.availability,
    required super.yearOfManufacture,
    required super.registrationNumber,
  });

  factory CarsModel.fromJson(Map<String, dynamic>? json) {
    return CarsModel(
      id: json?['id'],
      rate: json?['rate'],
      make: json?['make'],
      type: json?['type'],
      plan: json?['plan'],
      model: json?['model'],
      color: json?['color'],
      terms: json?['terms'],
      media: json?['media'],
      ownerId: json?['ownerId'],
      capacity: json?['capacity'],
      location: json?['location'],
      condition: json?['condition'],
      description: json?['description'],
      maxDuration: json?['maxDuration'],
      durationUnit: json?['durationUnit'],
      availability: json?['availability'],
      yearOfManufacture: json?['yearOfManufacture'],
      registrationNumber: json?['registrationNumber'],
    );
  }
}

class CarsMediaModel extends CarMedia {
  const CarsMediaModel({
    required super.id,
    required super.mediaURL,
  });

  factory CarsMediaModel.fromJson(Map<String, dynamic>? json) {
    return CarsMediaModel(id: json?['id'], mediaURL: json?['mediaURL']);
  }
}
