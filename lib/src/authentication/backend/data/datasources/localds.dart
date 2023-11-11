import 'dart:convert';

import 'package:rent_wheels/src/user/data/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BackendAuthenticationLocalDatasource {
  Future cacheUserInfo(UserInfoModel userInfo);
  Future<UserInfoModel> getCachedUserInfo();
  Future deleteCachedUserInfo();
}

class BackendAuthenticationLocalDatasourceImpl
    implements BackendAuthenticationLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'USER_CACHE_KEY';

  BackendAuthenticationLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future cacheUserInfo(UserInfoModel userInfo) {
    final cacheData = jsonEncode(userInfo.toJson());
    return sharedPreferences.setString(cacheKey, cacheData);
  }

  @override
  Future deleteCachedUserInfo() {
    return sharedPreferences.remove(cacheKey);
  }

  @override
  Future<UserInfoModel> getCachedUserInfo() async {
    final cacheData = sharedPreferences.getString(cacheKey);

    if (cacheData == null) {
      throw Exception('Cache error');
    }

    return UserInfoModel.fromJSON(json.decode(cacheData));
  }
}
