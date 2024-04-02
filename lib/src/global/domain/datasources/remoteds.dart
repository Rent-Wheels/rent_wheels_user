import 'package:firebase_auth/firebase_auth.dart';

abstract class GlobalRemoteDatasource {
  User? getCurrentUser();
  Future<void> reloadUser();
}

class GlobalRemoteDatasourceImpl implements GlobalRemoteDatasource {
  final FirebaseAuth firebaseAuth;

  GlobalRemoteDatasourceImpl({required this.firebaseAuth});

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }

  @override
  Future<void> reloadUser() async {
    return await firebaseAuth.currentUser?.reload();
  }
}
