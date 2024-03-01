import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/firebase_options.dart';
import 'package:rent_wheels/injection.dart' as di;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rent_wheels/src/loading/loading.dart';
import 'package:rent_wheels/src/mainSection/base.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/src/onboarding/presentation/onboarding.dart';
import 'package:rent_wheels/src/authentication/login/presentation/login.dart';
import 'package:rent_wheels/src/authentication/verify/presentation/verify_email.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Rent Wheels',
    home: ConnectionPage(),
  ));
}

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool firstTime = true;
  Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('firstTime')!;
  }

  userStatus() async {
    firstTime = await getOnboardingStatus();

    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await global.setGlobals(currentUser: user);

      final userDetails = await RentWheelsUserMethods()
          .getUserDetails(userId: global.user!.uid);

      await global.setGlobals(fetchedUserDetails: userDetails);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userStatus(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (firstTime) {
              return const OnboardingScreen();
            } else if (global.user != null && global.userDetails != null) {
              if (global.user!.emailVerified) {
                return const MainSection();
              }
              return const VerifyEmail();
            } else {
              return const Login();
            }

          default:
            return const LoadingScreen();
        }
      },
    );
  }
}
