import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/firebase/firebase_auth_service.dart';
import 'package:rent_wheels/core/auth/firebase/firebase_auth_provider.dart';

class AuthService implements FirebaseAuthProvider {
  final FirebaseAuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthService());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String avatar,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required DateTime dob,
    required String residence,
  }) =>
      provider.createUserWithEmailAndPassword(
        avatar: avatar,
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        password: password,
        dob: dob,
        residence: residence,
      );

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required email,
    required password,
  }) =>
      provider.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  @override
  Future<void> verifyEmail({required User user}) =>
      provider.verifyEmail(user: user);

  @override
  Future<void> resetPassword({
    required email,
  }) =>
      provider.resetPassword(email: email);

  @override
  Future<void> updateUserDetails(
          {required User user, String? email, String? password}) =>
      provider.updateUserDetails(
        user: user,
        email: email,
        password: password,
      );

  @override
  Future<void> deleteUser({
    required User user,
  }) =>
      provider.deleteUser(user: user);

  @override
  Future<void> reauthenticateUser({
    required email,
    required password,
  }) =>
      provider.reauthenticateUser(
        email: email,
        password: password,
      );
}
