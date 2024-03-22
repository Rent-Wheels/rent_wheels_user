import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/src/global/data/usecases/get_current_user.dart';
import 'package:rent_wheels/src/global/data/usecases/get_onboarding_status.dart';
import 'package:rent_wheels/src/global/data/usecases/reload_user.dart';
import 'package:rent_wheels/src/global/data/usecases/update_onboarding_status.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

class GlobalProvider extends ChangeNotifier {
  final ReloadUser reloadUser;
  final GetCurrentUser getCurrentUser;
  final GetOnboardingStatus getOnboardingStatus;
  final UpdateOnboardingStatus updateOnboardingStatus;

  GlobalProvider({
    required this.reloadUser,
    required this.getCurrentUser,
    required this.getOnboardingStatus,
    required this.updateOnboardingStatus,
  });

  User? _user;
  BackendUserInfo? _userDetails;
  final Map<String, String> _headers = Urls().headers;

  User? get user => _user;
  Map<String, String> get headers => _headers;
  BackendUserInfo? get userDetails => _userDetails;
  User? get currentUser => getCurrentUser.call();
  LinearGradient get shimmerGradient => _shimmerGradient;
  bool get onboardingStatus => getOnboardingStatus.call();
  Future<String?>? get accessToken async => await user?.getIdToken();

  final LinearGradient _shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  updateHeaders() {
    accessToken?.then(
      (value) => _headers.addAll(
        {
          'Authorization': 'Bearer $value',
        },
      ),
    );
  }

  updateCurrentUser(User? user) {
    _user = user;
    notifyListeners();
  }

  updateUserDetails(BackendUserInfo value) {
    _userDetails = value;
    notifyListeners();
  }

  setOnboardingStatus(bool value) async {
    await updateOnboardingStatus.call(value);
  }

  reloadCurrentUser() async {
    await reloadUser.call();
    _user = getCurrentUser.call();
  }
}
