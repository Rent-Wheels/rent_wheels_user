import 'dart:convert';

import 'package:rent_wheels/src/user/data/model/user_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDatasource {
  Future<String> getUserRegion();
  Future cacheUserDetails(BackendUserInfoModel user);
  Future<BackendUserInfoModel> getCachedUserDetails();
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = 'USER_CACHE';

  UserLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future cacheUserDetails(BackendUserInfoModel user) async {
    final encodedInfo = jsonEncode(user.toJson());

    return await sharedPreferences.setString(cacheKey, encodedInfo);
  }

  @override
  Future<BackendUserInfoModel> getCachedUserDetails() async {
    final cachedUser = sharedPreferences.getString(cacheKey);

    if (cachedUser == null) throw Exception('Cache Error');

    return BackendUserInfoModel.fromJSON(jsonDecode(cachedUser));
  }

  @override
  Future<String> getUserRegion() async {
    final user = await getCachedUserDetails();

    List<String>? splitLocation = user.placeOfResidence?.split(', ');
    return '${splitLocation?[splitLocation.length - 2]}, ${splitLocation?[splitLocation.length - 1]}';
  }
}
