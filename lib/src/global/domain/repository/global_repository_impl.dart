import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/src/global/data/repository/global_repository.dart';
import 'package:rent_wheels/src/global/domain/datasources/localds.dart';
import 'package:rent_wheels/src/global/domain/datasources/remoteds.dart';

class GlobalRepositoryImpl implements GlobalRepository {
  final GlobalRemoteDatasource remoteDatasource;
  final GlobalLocalDatasource localDatasource;

  GlobalRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
  });

  @override
  User? getCurrentUser() {
    return remoteDatasource.getCurrentUser();
  }

  @override
  bool getOnboardingStatus() {
    return localDatasource.getOnboardingStatus();
  }

  @override
  Future updateOnboardingStatus(bool status) {
    return localDatasource.updateOnboardingStatus(status);
  }

  @override
  Future<void> reloadUser() async {
    return await remoteDatasource.reloadUser();
  }
}
