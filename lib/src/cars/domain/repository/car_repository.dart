import 'package:dartz/dartz.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

abstract class CarRepository {
  ///get all available cars
  Future<Either<String, List<Cars>>> getAllAvailableCars(
    Map<String, dynamic> params,
  );
}
