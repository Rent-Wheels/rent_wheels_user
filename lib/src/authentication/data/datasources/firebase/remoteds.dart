import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthenticationRemoteDatasource {
  // logout
  Future<void> logout();

  /// create user with email and password

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// sign in with email and password

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// verify user

  Future<void> verifyEmail({required User user});

  /// reset password

  Future<void> resetPassword({required String email});

  /// delete user

  Future<void> deleteUserFromFirebase({required User user});

  /// reauthenticate user

  Future<UserCredential> reauthenticateUser({
    required User user,
    required String email,
    required String password,
  });

  /// update user details
  Future<void> updateUserDetails({
    required User user,
    String? email,
    String? password,
  });
}
