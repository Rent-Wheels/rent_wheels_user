import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/user/domain/repository/user_repository.dart';

class GetUserDetails extends UseCase<BackendUserInfo, Map<String, dynamic>> {
  final UserRepository repository;

  GetUserDetails({required this.repository});
  @override
  Future<Either<String, BackendUserInfo>> call(
      Map<String, dynamic> params) async {
    return await repository.getUserDetails(params);
  }
}
