import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/authentication/domain/repository/backend/backend_authentication_repository.dart';

class CreateOrUpdateUser
    extends UseCase<BackendUserInfo, Map<String, dynamic>> {
  final BackendAuthenticationRepository repository;

  CreateOrUpdateUser({required this.repository});
  @override
  Future<Either<String, BackendUserInfo>> call(
      Map<String, dynamic> params) async {
    return await repository.createOrUpdateUser(params);
  }
}
