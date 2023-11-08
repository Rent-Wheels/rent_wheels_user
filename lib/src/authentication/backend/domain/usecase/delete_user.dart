import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/authentication/backend/domain/repository/backend_authentication_repository.dart';

class DeleteUser extends UseCase<void, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  DeleteUser({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) {
    return repository.deleteUser(params);
  }
}
