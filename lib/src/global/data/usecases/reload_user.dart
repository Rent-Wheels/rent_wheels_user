import 'package:rent_wheels/src/global/data/repository/global_repository.dart';

class ReloadUser {
  final GlobalRepository repository;

  ReloadUser({required this.repository});

  Future<void> call() async {
    return await repository.reloadUser();
  }
}
