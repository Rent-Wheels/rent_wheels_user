import 'package:rent_wheels/core/models/user/user_model.dart';

abstract class RentWheelsUserEndpoints {
  Future<BackendUser> getUserDetails({required String userId});
  Future<BackendUser> getRenterDetails({required String userId});
}
