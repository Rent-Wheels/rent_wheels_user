import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/src/authentication/firebase/domain/repository/firebase_auth_repo.dart';

class FirebaseAuthenticationRepositoryImpl
    implements FirebaseAuthenticationRepository {
  // logout
  @override
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }
  // initialize firebase

  @override
  Future<Either<String, void>> deleteUser(Map<String, dynamic> params) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  /// create user with email and password
  @override
  Future<Either<String, void>> initialize() {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  /// sign in with email and password
  @override
  Future<Either<String, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  /// verify user
  @override
  Future<Either<String, UserCredential>> reauthenticateUser(
      Map<String, dynamic> params) {
    // TODO: implement reauthenticateUser
    throw UnimplementedError();
  }

  /// reset password
  @override
  Future<Either<String, void>> resetPassword(Map<String, dynamic> params) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  /// delete user
  @override
  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      Map<String, dynamic> params) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  /// reauthenticate user
  @override
  Future<Either<String, void>> updateUserDetails(Map<String, dynamic> params) {
    // TODO: implement updateUserDetails
    throw UnimplementedError();
  }

  /// update user details
  @override
  Future<Either<String, void>> verifyEmail(Map<String, dynamic> params) {
    // TODO: implement verifyEmail
    throw UnimplementedError();
  }
}
