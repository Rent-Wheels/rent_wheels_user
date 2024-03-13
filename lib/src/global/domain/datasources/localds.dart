import 'package:shared_preferences/shared_preferences.dart';

abstract class GlobalLocalDatasource {
  bool getOnboardingStatus();
  Future updateOnboardingStatus(bool status);
}

class GlobalLocalDatasourceImpl implements GlobalLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'ONBOARDING_CHECK';

  GlobalLocalDatasourceImpl({required this.sharedPreferences});

  @override
  bool getOnboardingStatus() {
    return sharedPreferences.getBool(cacheKey) ?? false;
  }

  @override
  Future updateOnboardingStatus(bool status) async {
    return await sharedPreferences.setBool(cacheKey, status);
  }
}
