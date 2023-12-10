import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/user/domain/repository/user_repository.dart';

class GetCachedUserInfo extends UseCase<BackendUserInfo, NoParams> {
  final UserRepository repository;

  GetCachedUserInfo({required this.repository});
  @override
  Future<Either<String, BackendUserInfo>> call(NoParams params) async {
    return await repository.getCachedUserInfo();
  }
}
