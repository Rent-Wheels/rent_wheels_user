import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthenticationRepository {
  Future<Either<String, void>> logout();

  Future<Either<String, void>> initialize();

  /// create user with email and password params
  /// 1. email
  /// 2. password

  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params);

  /// sign in with email and password params
  /// 1. email
  /// 2. password

  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      Map<String, dynamic> params);

  /// verify user
  /// 1. user

  Future<Either<String, void>> verifyEmail(Map<String, dynamic> params);

  /// reset password params
  /// 1. email

  Future<Either<String, void>> resetPassword(Map<String, dynamic> params);

  /// delete user params
  /// 1. user

  Future<Either<String, void>> deleteUser(Map<String, dynamic> params);

  /// reauthenticate user params
  /// 1. email
  /// 2. password

  Future<Either<String, UserCredential>> reauthenticateUser(
      Map<String, dynamic> params);

  /// update user details params
  /// 1. user: required
  /// 2. email
  /// 3. password

  Future<Either<String, void>> updateUserDetails(Map<String, dynamic> params);
}
