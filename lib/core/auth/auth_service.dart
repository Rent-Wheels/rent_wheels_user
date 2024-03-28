import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/firebase/firebase_auth_service.dart';
import 'package:rent_wheels/core/auth/firebase/firebase_auth_provider.dart';

class AuthService implements FirebaseAuthProvider {
  final FirebaseAuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthService());

  @override
  Future<void> logout() => provider.logout();

  @override
  Future<void> updateUserDetails(
          {required User user, String? email, String? password}) =>
      provider.updateUserDetails(
        user: user,
        email: email,
        password: password,
      );
}
