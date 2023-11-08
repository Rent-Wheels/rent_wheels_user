import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/authentication/backend/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/authentication/backend/domain/repository/backend_authentication_repository.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

class BackendAuthenticationRepositoryImpl
    implements BackendAuthenticationRepository {
  final NetworkInfo networkInfo;
  final BackendAuthenticationRemoteDatasource remoteDatasource;

  BackendAuthenticationRepositoryImpl(
      {required this.networkInfo, required this.remoteDatasource});

  /// create or update user

  @override
  Future<Either<String, UserInfo>> createOrUpdateUser(
      Map<String, dynamic> params) {
    // TODO: implement createOrUpdateUser
    throw UnimplementedError();
  }

  /// delete user

  @override
  Future<Either<String, void>> deleteUser(Map<String, dynamic> params) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }
}
