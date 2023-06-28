import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthProvider {
  Future<void> logout();

  Future<void> initialize();

  Future<UserCredential> createUserWithEmailAndPassword({
    required String avatar,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required DateTime dob,
    required String residence,
  });

  Future<UserCredential> signInWithEmailAndPassword({
    required email,
    required password,
  });

  Future<void> verifyEmail({required User user});

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

  Future<void> updateUserDetails({
    required User user,
    String? email,
    String? password,
  });
}
