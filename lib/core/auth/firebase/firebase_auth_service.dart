import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/core/backend/files/file_methods.dart';

import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/auth/backend/backend_auth_service.dart';
import 'package:rent_wheels/core/auth/firebase/firebase_auth_provider.dart';

class FirebaseAuthService implements FirebaseAuthProvider {
  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    global.resetGlobals();
  }

  @override
  Future<void> updateUserDetails(
      {required User user, String? email, String? password}) async {
    try {
      if (email != null) {
        await user.updateEmail(email);
      }
      if (password != null) {
        await user.updatePassword(password);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw RequiresRecentLoginException();
      } else if (e.code == 'email-already-in-use') {
        throw InvalidEmailException();
      }
    }
  }

  @override
  Future<void> deleteUser({required User user}) async {
    try {
      await RentWheelsFilesMethods()
          .deleteDirectory(directoryPath: 'users/${user.uid}/');

      await RentWheelsFilesMethods()
          .deleteDirectory(directoryPath: 'users/${user.uid}/cars');
      await user.delete();
      await BackendAuthService().deleteUser(userId: user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw RequiresRecentLoginException();
      }
    }
  }

  @override
  Future<UserCredential?> reauthenticateUser(
      {required email, required password}) async {
    try {
      return await global.user?.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: email, password: password));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw InvalidPasswordAuthException();
      }
      throw Exception(e);
    }
  }
}
