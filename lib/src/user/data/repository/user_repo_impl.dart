import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/user/data/datasource/localds.dart';
import 'package:rent_wheels/src/user/data/datasource/remoteds.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/user/domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final NetworkInfo networkInfo;
  final UserLocalDatasource localDatasource;
  final UserRemoteDatasource remoteDatasource;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<String, String>> getUserRegion() async {
    if (!(await networkInfo.isConnected)) {
      return Left(
        networkInfo.noNetworkMessage,
      );
    }

    try {
      final response = await localDatasource.getUserRegion();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, BackendUserInfo>> getCachedUserInfo() async {
    if (!(await networkInfo.isConnected)) {
      return Left(
        networkInfo.noNetworkMessage,
      );
    }

    try {
      final response = await localDatasource.getCachedUserDetails();
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, BackendUserInfo>> getUserDetails(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(
        networkInfo.noNetworkMessage,
      );
    }

    try {
      final response = await remoteDatasource.getUserDetails(params);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
