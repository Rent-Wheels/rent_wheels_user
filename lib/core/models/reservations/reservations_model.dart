class ReservationModel {
  Customer? customer;
  String? renter;
  String? car;
  DateTime? startDate;
  DateTime? returnDate;
  String? status;
  String? destination;
  num? price;

  ReservationModel({
    this.customer,
    this.renter,
    this.car,
    this.startDate,
    this.returnDate,
    this.status,
    this.destination,
    this.price,
  });

  factory ReservationModel.fromJSON(Map<String, dynamic> json) {
    return ReservationModel(
      customer: Customer.fromJSON(json['customer']),
      renter: json['renter'],
      car: json['car'],
      startDate: DateTime.parse(json['startDate']),
      returnDate: DateTime.parse(json['returnDate']),
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
