import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/authentication/backend/domain/repository/backend_authentication_repository.dart';

class CreateUser extends UseCase<UserInfo, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  CreateUser({required this.repository});
  @override
  Future<Either<String, UserInfo>> call(Map<String, dynamic> params) async {
    return await repository.createUser(params);
  }
}
