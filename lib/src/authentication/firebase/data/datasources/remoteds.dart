import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rent_wheels/firebase_options.dart';

abstract class FirebaseAuthenticationRemoteDatasource {
  // logout
  Future<void> logout();

// initialize firebase
  Future<void> initialize();

  /// create user with email and password

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// sign in with email and password

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// verify user

  Future<void> verifyEmail({required User user});

  /// reset password

  Future<void> resetPassword({required String email});

  /// delete user

  Future<void> deleteUser({required User user});

  /// reauthenticate user

  Future<UserCredential> reauthenticateUser({
    required User user,
    required String email,
    required String password,
  });

  /// update user details
  Future<void> updateUserDetails({
    required User user,
    String? email,
    String? password,
  });
}

class FirebaseAuthenticationRemoteDatasourceImpl
    implements FirebaseAuthenticationRemoteDatasource {
  final FirebaseAuth firebase;

  FirebaseAuthenticationRemoteDatasourceImpl({required this.firebase});

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebase.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> deleteUser({required User user}) async {
    return await user.delete();
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Future<void> logout() async {
    return await firebase.signOut();
  }

  @override
  Future<UserCredential> reauthenticateUser({
    required User user,
    required String email,
    required String password,
  }) async {
    return await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return await firebase.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebase.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> updateUserDetails({
    required User user,
    String? email,
    String? password,
  }) async {
    if (email != null) {
      await user.updateEmail(email);
    }
    if (password != null) {
      await user.updatePassword(password);
    }
  }

  @override
  Future<void> verifyEmail({required User user}) async {
    return await user.sendEmailVerification();
  }
}
