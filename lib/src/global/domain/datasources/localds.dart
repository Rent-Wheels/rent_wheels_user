import 'package:shared_preferences/shared_preferences.dart';

abstract class GlobalLocalDatasource {
  bool getOnboardingStatus();
}

class GlobalLocalDatasourceImpl implements GlobalLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'ONBOARDING_CHECK';

  GlobalLocalDatasourceImpl({required this.sharedPreferences});

  @override
  bool getOnboardingStatus() {
    return sharedPreferences.getBool(cacheKey) ?? false;
  }
}
