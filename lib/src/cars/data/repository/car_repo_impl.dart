import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/cars/data/datasource/remoteds.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/domain/repository/car_repository.dart';

class CarRepositoryImpl implements CarRepository {
  final NetworkInfo networkInfo;
  final CarsRemoteDatasource remoteDatasource;

  CarRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });

  @override
  Future<Either<String, List<Car>>> getAllAvailableCars(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(
        networkInfo.noNetworkMessage,
      );
    }

    try {
      final response = await remoteDatasource.getAllAvailableCars(params);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
