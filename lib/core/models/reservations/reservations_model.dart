import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';

class ReservationModel {
  String? id;
  Customer? customer;
  Renter? renter;
  Car? car;
  DateTime? startDate;
  DateTime? returnDate;
  String? status;
  String? destination;
  num? price;
  DateTime? createdAt;
  DateTime? updatedAt;

  ReservationModel({
    this.id,
    this.customer,
    this.renter,
    this.car,
    this.startDate,
    this.returnDate,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.destination,
    this.price,
  });

  factory ReservationModel.fromJSON(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['_id'],
      customer: Customer.fromJSON(json['customer']),
      renter: Renter.fromJSON(json['renter']),
      car: Car.fromJSON(json['car']),
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'],
      destination: json['destination'],
      price: json['price'],
    );
  }
}

class Customer {
  String? id;
  String? name;

  Customer({
    this.id,
    this.name,
  });

  factory Customer.fromJSON(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
    );
  }
}
