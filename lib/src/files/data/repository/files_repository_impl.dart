import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/files/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/files/domain/repository/file_repository.dart';

class FileRepositoryImpl implements FileRepository {
  final NetworkInfo networkInfo;
  final FilesRemoteDatasource remoteDatasource;

  FileRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });

  @override
  Future<Either<String, void>> deleteDirectory(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.deleteDirectory(params);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteFile(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.deleteFile(params);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> getFileUrl(
    Map<String, dynamic> params,
  ) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.getFileUrl(params);
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
