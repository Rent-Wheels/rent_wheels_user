import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/renter/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';
import 'package:rent_wheels/src/renter/domain/repository/renter_repository.dart';

class RenterRepositoryImpl implements RenterRepository {
  final NetworkInfo networkInfo;
  final RenterRemoteDatasource remoteDatasource;

  RenterRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });
  @override
  Future<Either<String, Renter>> getRenterDetails(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(
        networkInfo.noNetworkMessage,
      );
    }

    try {
      final response = await remoteDatasource.getRenterDetails(params);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
