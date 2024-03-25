import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/domain/repository/car_repository.dart';

class GetAllAvailableCars extends UseCase<List<Car>, Map<String, dynamic>> {
  final CarRepository repository;

  GetAllAvailableCars({required this.repository});

  @override
  Future<Either<String, List<Car>>> call(Map<String, dynamic> params) async {
    return await repository.getAllAvailableCars(params);
  }
}
