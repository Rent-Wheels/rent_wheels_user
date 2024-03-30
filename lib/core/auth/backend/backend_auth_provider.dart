import 'package:rent_wheels/core/models/user/user_model.dart';

abstract class BackendAuthProvider {
  Future<BackendUser> updateUser({
    required String? avatar,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  });
}
