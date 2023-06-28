import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/models/user/user_model.dart';

abstract class BackendAuthProvider {
  Future<BackendUser> createUser({
    required String avatar,
    required User user,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  });

  Future<BackendUser> updateUser({
    required String? avatar,
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
