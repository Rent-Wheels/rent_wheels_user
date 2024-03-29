import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/authentication/domain/repository/firebase/firebase_auth_repo.dart';

class ResetPassword extends UseCase<void, Map<String, dynamic>> {
  final FirebaseAuthenticationRepository repository;

  ResetPassword({required this.repository});
  @override
  Future<Either<String, void>> call(Map<String, dynamic> params) async {
    return await repository.resetPassword(params);
  }
}
