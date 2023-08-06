import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/src/loading/loading.dart';
import 'package:rent_wheels/src/mainSection/base.dart';
import 'package:rent_wheels/src/authentication/login/presentation/login.dart';
import 'package:rent_wheels/src/authentication/verify/presentation/verify_email.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const RentWheelsApp());
}

class RentWheelsApp extends StatelessWidget {
  const RentWheelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rent Wheels',
      home: ConnectionPage(),
    );
  }
}

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  userStatus() async {
    await AuthService.firebase().initialize();

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
            if (global.user != null && global.userDetails != null) {
              if (global.user!.emailVerified) {
                return const MainSection(
                  pageIndex: 2,
                );
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
