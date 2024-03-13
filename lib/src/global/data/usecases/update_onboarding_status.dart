import 'package:rent_wheels/src/global/data/repository/global_repository.dart';

class UpdateOnboardingStatus {
  final GlobalRepository repository;

  UpdateOnboardingStatus({required this.repository});

  Future call(bool status) async {
    return await repository.updateOnboardingStatus(status);
  }
}
