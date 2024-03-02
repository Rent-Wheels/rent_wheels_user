import 'package:firebase_auth/firebase_auth.dart';

abstract class GlobalRepository {
  User? getCurrentUser();
  bool getOnboardingStatus();
}
