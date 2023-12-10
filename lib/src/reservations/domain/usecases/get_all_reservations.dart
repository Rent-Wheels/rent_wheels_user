import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/domain/repository/reservations_repository.dart';

class GetAllReservations
    extends UseCase<List<Reservation>, Map<String, dynamic>> {
  final ReservationsRepository repository;

  GetAllReservations({required this.repository});

  @override
  Future<Either<String, List<Reservation>>> call(
    Map<String, dynamic> params,
  ) async {
    return await repository.getAllReservations(params);
  }
}
