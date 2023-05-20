import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthProvider {
  Future<void> logout();

  Future<void> initialize();

  Future createUserWithEmailAndPassword({
    required email,
    required password,
  });

  Future signInWithEmailAndPassword({
    required email,
    required password,
  });

  Future<void> resetPassword({
    required email,
  });

  Future<void> deleteUser({
    required User user,
  });

  Future<void> reauthenticateUser({
    required email,
    required password,
  });
}
