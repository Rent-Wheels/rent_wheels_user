import 'package:firebase_auth/firebase_auth.dart';

abstract class GlobalRepository {
  User? getCurrentUser();
  Future<void> reloadUser();
  bool getOnboardingStatus();
  Future updateOnboardingStatus(bool status);
}
