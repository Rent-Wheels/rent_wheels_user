import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rent_wheels/core/backend/files/file_methods.dart';

import 'package:rent_wheels/firebase_options.dart';

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
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String avatar,
    required String name,
    required String phoneNumber,
    required String email,
    required String password,
    required DateTime dob,
    required String residence,
  }) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await BackendAuthService().createUser(
          avatar: avatar,
          user: credential.user!,
          name: name,
          phoneNumber: phoneNumber,
          email: email,
          dob: dob,
          residence: residence,
        );

        await verifyEmail(user: credential.user!);
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == 'email-already-in-use') {
        throw InvalidEmailException();
      }
      throw Exception(e);
    }
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required email,
    required password,
  }) async {
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
      throw GenericAuthException();
    }
  }

  @override
  Future<void> verifyEmail({required user}) async {
    await user.sendEmailVerification();
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
  Future<void> resetPassword({required email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw RequiresRecentLoginException();
      }
      throw Exception('Could not send email');
    }
  }

  @override
  Future<void> deleteUser({required User user}) async {
    try {
      await user.delete();
      await RentWheelsFilesMethods().deleteFile(filePath: 'users/${user.uid}/');
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
