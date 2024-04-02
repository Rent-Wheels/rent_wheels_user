import 'package:dartz/dartz.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';

abstract class RenterRepository {
  Future<Either<String, Renter>> getRenterDetails(
    Map<String, dynamic> params,
  );
}
