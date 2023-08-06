import 'package:rent_wheels/core/models/reservations/reservations_model.dart';

abstract class RentWheelsReservationsEndpoint {
  Future<List<ReservationModel>> getAllReservations();
  Future<ReservationModel> changeReservationStatus(
      {required String reservationId, required String status});
  Future<ReservationModel> makeReservation(
      {required ReservationModel reservationDetails});
}
