import 'package:rent_wheels/src/global/data/repository/global_repository.dart';

class GetOnboardingStatus {
  final GlobalRepository repository;

  GetOnboardingStatus({required this.repository});

  bool call() {
    return repository.getOnboardingStatus();
  }
}
