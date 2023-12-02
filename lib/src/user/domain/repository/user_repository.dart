import 'package:dartz/dartz.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

abstract class UserRepository {
  Future<Either<String, String>> getUserRegion();
  Future<Either<String, BackendUserInfo>> getCachedUserInfo();
}
