import 'package:rent_wheels/src/user/data/model/user_info_model.dart';

abstract class BackendAuthenticationRemoteDatasource {
  /// create or update user

  Future<BackendUserInfoModel> createOrUpdateUser(Map<String, dynamic> params);

  /// delete user

  Future<void> deleteUserFromBackend(Map<String, dynamic> params);
}
