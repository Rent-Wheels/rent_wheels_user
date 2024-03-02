import 'package:firebase_auth/firebase_auth.dart';

abstract class GlobalRemoteDatasource {
  User? getCurrentUser();
}

class GlobalRemoteDatasourceImpl implements GlobalRemoteDatasource {
  final FirebaseAuth firebaseAuth;

  GlobalRemoteDatasourceImpl({required this.firebaseAuth});

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
