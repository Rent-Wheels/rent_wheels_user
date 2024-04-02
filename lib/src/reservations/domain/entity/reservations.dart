import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';
import 'package:rent_wheels/src/reservations/domain/entity/customer.dart';

class Reservation extends Equatable {
  final Car? car;
  final num? price;
  final Renter? renter;
  final Customer? customer;
  final String? id,
      status,
      updatedAt,
      createdAt,
      startDate,
      returnDate,
      destination;

  const Reservation({
    required this.id,
    required this.car,
    required this.price,
    required this.renter,
    required this.status,
    required this.customer,
    required this.startDate,
    required this.createdAt,
    required this.updatedAt,
    required this.returnDate,
    required this.destination,
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

  Map<String, dynamic> toMap() => {
        'id': id,
        'price': price,
        'status': status,
        'car': car?.toMap(),
        'startDate': startDate,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'returnDate': returnDate,
        'renter': renter?.toMap(),
        'destination': destination,
        'customer': customer?.toMap(),
      };
}
