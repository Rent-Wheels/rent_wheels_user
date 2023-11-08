import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/authentication/firebase/domain/repository/firebase_auth_repo.dart';

class DeleteUser extends UseCase<void, Map<String, dynamic>> {
  final FirebaseAuthenticationRepository repository;

  DeleteUser({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.deleteUser(params);
  }
}
