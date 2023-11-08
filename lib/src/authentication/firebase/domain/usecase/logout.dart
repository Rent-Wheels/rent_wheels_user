import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/authentication/firebase/domain/repository/firebase_auth_repo.dart';

class Logout extends UseCase<void, NoParams> {
  final FirebaseAuthenticationRepository repository;

  Logout({required this.repository});

  @override
  Future<Either<String, void>> call(NoParams params) async {
    return await repository.logout();
  }
}
