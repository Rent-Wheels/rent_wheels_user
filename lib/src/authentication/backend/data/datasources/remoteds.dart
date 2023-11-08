import 'package:rent_wheels/src/user/data/model/user_info_model.dart';

abstract class BackendAuthenticationRemoteDatasource {
  /// create or update user

  Future<UserInfoModel> createOrUpdateUser(Map<String, dynamic> params);

  /// delete user

  Future<void> deleteUser(Map<String, dynamic> params);
}
