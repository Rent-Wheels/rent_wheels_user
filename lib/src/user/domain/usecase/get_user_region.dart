import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/repository/user_repository.dart';

class GetUserRegion extends UseCase<String, NoParams> {
  final UserRepository repository;

  GetUserRegion({required this.repository});
  @override
  Future<Either<String, String>> call(NoParams params) async {
    return await repository.getUserRegion();
  }
}
