import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter_info.dart';
import 'package:rent_wheels/src/reservations/domain/entity/customer.dart';

class Reservation extends Equatable {
  final Cars? car;
  final num? price;
  final Customer? customer;
  final RenterInfo? renter;
  final String? id,
      status,
      startDate,
      returnDate,
      destination,
      createdAt,
      updatedAt;

  const Reservation({
    required this.car,
    required this.price,
    required this.customer,
    required this.renter,
    required this.id,
    required this.status,
    required this.startDate,
    required this.returnDate,
    required this.destination,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        car,
        price,
        customer,
        renter,
        id,
        status,
        startDate,
        returnDate,
        destination,
        createdAt,
        updatedAt,
      ];
}
