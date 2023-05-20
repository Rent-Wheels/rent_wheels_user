import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rent_wheels/firebase/auth/auth_exceptions.dart';

import 'package:rent_wheels/firebase_options.dart';
import 'package:rent_wheels/firebase/auth/auth_provider.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future createUserWithEmailAndPassword({required email, password}) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await verifyEmail(user: user.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw InvalidEmailException();
      }
    }
  }

  @override
  Future signInWithEmailAndPassword({required email, required password}) async {
    try {
      return await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw InvalidPasswordAuthException();
      }
    }
  }

  Future<void> verifyEmail({required user}) async {
    await user.sendEmailVerification();
  }

  @override
  Future<void> resetPassword({required email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw GenericAuthException();
      }
    }
  }

  @override
  Future<void> deleteUser({required User user}) async {
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw GenericAuthException();
      }
    }
  }

  @override
  Future<void> reauthenticateUser({required email, required password}) async {
    final UserCredential userCredential =
        await signInWithEmailAndPassword(email: email, password: password);

    await userCredential.user
        ?.reauthenticateWithCredential(userCredential.credential!);
  }
}
