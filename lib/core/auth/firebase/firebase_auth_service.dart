import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
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
}
