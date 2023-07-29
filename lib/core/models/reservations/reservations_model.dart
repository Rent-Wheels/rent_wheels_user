class ReservationModel {
  String? customer;
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
      customer: json['customer'],
      renter: json['renter'],
      car: json['car'],
      startDate: json['startDate'],
      returnDate: json['returnDate'],
      status: json['status'],
      destination: json['destination'],
      price: json['price'],
    );
  }
}
