enum AvailableCarsType { preview, allAvailableCars }

enum ReservationView { make, view }

enum PaymentMethods {
  vfCash(value: 'VFCash'),
  creditCard(value: 'Credit Card'),
  airtelTigoCash(value: 'Tigo Cash'),
  mobileMoney(value: 'MTN Mobile Money');

  const PaymentMethods({required this.value});

  final String value;
}
