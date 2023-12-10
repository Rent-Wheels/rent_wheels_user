import 'package:dartz/dartz.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter_info.dart';
import 'package:rent_wheels/src/renter/domain/repository/renter_repository.dart';

class GetRenterDetails extends UseCase<RenterInfo, Map<String, dynamic>> {
  final RenterRepository repository;

  GetRenterDetails({required this.repository});
  @override
  Future<Either<String, RenterInfo>> call(Map<String, dynamic> params) async {
    return await repository.getRenterDetails(params);
  }
}
