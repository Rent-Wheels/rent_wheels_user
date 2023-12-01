import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/authentication/domain/repository/backend/backend_authentication_repository.dart';

class DeleteUserFromBackend extends UseCase<void, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  DeleteUserFromBackend({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.deleteUserFromBackend(params);
  }
}
