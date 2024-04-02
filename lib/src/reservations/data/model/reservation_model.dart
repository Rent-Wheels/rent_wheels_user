import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/renter/data/models/renter_model.dart';
import 'package:rent_wheels/src/reservations/domain/entity/customer.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';

class ReservationModel extends Reservation {
  const ReservationModel({
    required super.car,
    required super.price,
    required super.customer,
    required super.renter,
    required super.id,
    required super.status,
    required super.startDate,
    required super.returnDate,
    required super.destination,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ReservationModel.fromJSON(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      customer: CustomerModel.fromJSON(json['customer']),
      renter: RenterModel.fromJSON(json['renter']),
      car: CarModel.fromJSON(json['car']),
      startDate: json['startDate'],
      returnDate: json['returnDate'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      status: json['status'],
      destination: json['destination'],
      price: json['price'],
    );
  }
}

class CustomerModel extends Customer {
  const CustomerModel({
    required super.id,
    required super.name,
  });

  factory CustomerModel.fromJSON(Map<String, dynamic>? json) {
    return CustomerModel(
      id: json?['id'],
      name: json?['name'],
    );
  }
}
