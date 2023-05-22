import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/firebase/auth/auth_provider.dart';
import 'package:rent_wheels/core/firebase/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<void> logout() => provider.logout();

  @override
  Future createUserWithEmailAndPassword({
    required email,
    required password,
  }) =>
      provider.createUserWithEmailAndPassword(email: email, password: password);

  @override
  Future signInWithEmailAndPassword({
    required email,
    required password,
  }) =>
      provider.signInWithEmailAndPassword(email: email, password: password);

  @override
  Future<void> resetPassword({
    required email,
  }) =>
      provider.resetPassword(email: email);

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
      provider.reauthenticateUser(email: email, password: password);
}
