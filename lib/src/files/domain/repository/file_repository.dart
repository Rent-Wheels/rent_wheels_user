import 'package:dartz/dartz.dart';

abstract class FileRepository {
  ///get file url params
  ///1. file: File
  ///2. filePath: String
  Future<Either<String, String>> getFileUrl(Map<String, dynamic> params);

  ///delete File params
  ///1. filePath: String
  Future<Either<String, void>> deleteFile(Map<String, dynamic> params);

  ///delete Directory params
  ///1. directoryPath: String
  Future<Either<String, void>> deleteDirectory(Map<String, dynamic> params);
}
