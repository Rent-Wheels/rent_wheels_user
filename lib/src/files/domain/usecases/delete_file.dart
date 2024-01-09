import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/files/domain/repository/file_repository.dart';

class DeleteFile extends UseCase<void, Map<String, dynamic>> {
  final FileRepository repository;

  DeleteFile({required this.repository});

  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.deleteFile(params);
  }
}
