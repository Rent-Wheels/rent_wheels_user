import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthProvider {
  Future<void> logout();

  Future<void> deleteUser({
    required User user,
  });

  Future<UserCredential?> reauthenticateUser({
    required email,
    required password,
  });

  Future<void> updateUserDetails({
    required User user,
    String? email,
    String? password,
  });
}
