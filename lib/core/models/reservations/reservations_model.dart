class ReservationModel {
  String? id;
  Customer? customer;
  // Renter? renter;
  // Car? car;
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
    // this.renter,
    // this.car,
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
      customer:
          json['customer'] != null ? Customer.fromJSON(json['customer']) : null,
      // renter: json['renter'] != null ? Renter.fromJSON(json['renter']) : null,
      // car: json['car'] != null ? Car.fromJSON(json['car']) : null,
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
