import 'package:rent_wheels/core/models/auth/auth_model.dart';

abstract class BackendAuthProvider {
  Future<User> createUser({
    required String avatar,
    required String userId,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  });
  Future<void> deleteUser({
    required String userId,
  });
}
