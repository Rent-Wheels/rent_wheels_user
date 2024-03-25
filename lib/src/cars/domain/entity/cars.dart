import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/cars/domain/entity/car_media.dart';

class Cars extends Equatable {
  final bool? availability;
  final List<CarMedia>? media;
  final num? capacity, maxDuration, rate;
  final String? id,
      make,
      type,
      plan,
      terms,
      model,
      color,
      ownerId,
      location,
      condition,
      description,
      durationUnit,
      yearOfManufacture,
      registrationNumber;

  const Cars({
    required this.id,
    required this.rate,
    required this.make,
    required this.type,
    required this.plan,
    required this.model,
    required this.color,
    required this.terms,
    required this.media,
    required this.ownerId,
    required this.capacity,
    required this.location,
    required this.condition,
    required this.description,
    required this.maxDuration,
    required this.durationUnit,
    required this.availability,
    required this.yearOfManufacture,
    required this.registrationNumber,
  });

  @override
  List<Object?> get props => [
        id,
        rate,
        make,
        type,
        plan,
        model,
        color,
        terms,
        media,
        ownerId,
        capacity,
        location,
        condition,
        description,
        maxDuration,
        durationUnit,
        availability,
        yearOfManufacture,
        registrationNumber,
      ];

  Map<String, dynamic> toMap() => {
        'id': id,
        'rate': rate,
        'make': make,
        'type': type,
        'plan': plan,
        'model': model,
        'color': color,
        'terms': terms,
        'ownerId': ownerId,
        'capacity': capacity,
        'location': location,
        'condition': condition,
        'description': description,
        'maxDuration': maxDuration,
        'durationUnit': durationUnit,
        'availability': availability,
        'yearOfManufacture': yearOfManufacture,
        'registrationNumber': registrationNumber,
        'media': media?.map<Map<String, dynamic>>((e) => e.toMap()).toList(),
      };
}
