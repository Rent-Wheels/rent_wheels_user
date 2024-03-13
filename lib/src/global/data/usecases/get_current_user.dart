import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/src/global/data/repository/global_repository.dart';

class GetCurrentUser {
  final GlobalRepository repository;

  GetCurrentUser({required this.repository});

  User? call() {
    return repository.getCurrentUser();
  }
}
