import 'package:rent_wheels/core/models/reservations/reservations_model.dart';

abstract class RentWheelsReservationsEndpoint {
  Stream<List<ReservationModel>> getAllReservations();
  Future<ReservationModel> makeReservation(
      {required ReservationModel reservationDetails});
}
