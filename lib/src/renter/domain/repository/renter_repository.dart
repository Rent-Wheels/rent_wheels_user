import 'package:dartz/dartz.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter_info.dart';

abstract class RenterRepository {
  Future<Either<String, RenterInfo>> getRenterDetails(
    Map<String, dynamic> params,
  );
}
