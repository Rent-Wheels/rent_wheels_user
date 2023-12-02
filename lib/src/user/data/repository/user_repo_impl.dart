import 'package:dartz/dartz.dart';
import 'package:rent_wheels/src/user/data/datasource/localds.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDatasource localDatasource;

  UserRepositoryImpl({required this.localDatasource});

  @override
  Future<Either<String, String>> getUserRegion() async {
    try {
      final response = await localDatasource.getUserRegion();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, BackendUserInfo>> getCachedUserInfo() async {
    try {
      final response = await localDatasource.getCachedUserDetails();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
