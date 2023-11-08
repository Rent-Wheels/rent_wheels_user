import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthenticationRemoteDatasource {
  // logout
  Future<void> logout();

// initialize firebase
  Future<void> initialize();

  /// create user with email and password

  Future<UserCredential> createUserWithEmailAndPassword(
      Map<String, dynamic> params);

  /// sign in with email and password

  Future<UserCredential> signInWithEmailAndPassword(
      Map<String, dynamic> params);

  /// verify user

  Future<void> verifyEmail(Map<String, dynamic> params);

  /// reset password

  Future<void> resetPassword(Map<String, dynamic> params);

  /// delete user

  Future<void> deleteUser(Map<String, dynamic> params);

  /// reauthenticate user

  Future<UserCredential> reauthenticateUser(Map<String, dynamic> params);

  /// update user details
  Future<void> updateUserDetails(Map<String, dynamic> params);
}
