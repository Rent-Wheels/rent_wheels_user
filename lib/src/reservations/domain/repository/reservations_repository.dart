import 'package:dartz/dartz.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';

abstract class ReservationsRepository {
  Future<Either<String, List<Reservation>>> getAllReservations(
    Map<String, dynamic> params,
  );
  Future<Either<String, Reservation>> changeReservationStatus(
    Map<String, dynamic> params,
  );
  Future<Either<String, Reservation>> makeReservation(
    Map<String, dynamic> params,
  );
}
