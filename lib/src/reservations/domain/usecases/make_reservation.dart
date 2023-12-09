import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/domain/repository/reservations_repository.dart';

class MakeReservation extends UseCase<Reservation, Map<String, dynamic>> {
  final ReservationsRepository repository;

  MakeReservation({required this.repository});

  @override
  Future<Either<String, Reservation>> call(Map<String, dynamic> params) async {
    return await repository.makeReservation(params);
  }
}
