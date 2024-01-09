import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/files/domain/repository/file_repository.dart';

class GetFileUrl extends UseCase<String, Map<String, dynamic>> {
  final FileRepository repository;

  GetFileUrl({required this.repository});

  @override
  Future<Either<String, String>> call(Map<String, dynamic> params) async {
    return await repository.getFileUrl(params);
  }
}
