import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:rent_wheels/firebase_options.dart';
import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/models/enums/auth.enum.dart';
import 'package:rent_wheels/core/auth/backend/backend_auth_service.dart';
import 'package:rent_wheels/core/auth/firebase/firebase_auth_provider.dart';

class FirebaseAuthService implements FirebaseAuthProvider {
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
  Future createUserWithEmailAndPassword({
    required String avatar,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required DateTime dob,
    required String residence,
  }) async {
    try {
      final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (user.user != null) {
        await verifyEmail(user: user.user!);

        await BackendAuthService().createUser(
          avatar: avatar,
          userId: user.user!.uid,
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          dob: dob,
          residence: residence,
          role: Roles.user,
        );
      }
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
      await BackendAuthService().deleteUser(userId: user.uid);
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
