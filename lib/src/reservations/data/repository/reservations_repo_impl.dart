import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/reservations/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/reservations/domain/entity/reservations.dart';
import 'package:rent_wheels/src/reservations/domain/repository/reservations_repository.dart';

class ReservationsRepositoryImpl implements ReservationsRepository {
  final NetworkInfo networkInfo;
  final ReservationsRemoteDatasource remoteDatasource;

  ReservationsRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });

  @override
  Future<Either<String, Reservation>> changeReservationStatus(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.changeReservationStatus(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<Reservation>>> getAllReservations(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.getAllReservations(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Reservation>> makeReservation(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.makeReservation(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
