import 'package:rent_wheels/core/models/user/user_model.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';

abstract class RentWheelsUserEndpoints {
  Future<BackendUser> getUserDetails({required String userId});
  Future<Renter> getRenterDetails({required String userId});
}
