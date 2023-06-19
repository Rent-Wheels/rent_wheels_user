import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/screen_implementer.dart';

import 'package:rent_wheels/tester.dart';
import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/src/home/presentation/home.dart';
import 'package:rent_wheels/src/login/presentation/login.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/src/verify/presentation/verify_email.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const RentWheelsApp());
}

class RentWheelsApp extends StatelessWidget {
  const RentWheelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Wheels',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SelectLocation(),
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
            if (global.user != null) {
              if (global.user!.emailVerified) {
                return const Home();
              }
              return const VerifyEmail();
            } else {
              return const Login();
            }

          default:
            return const Tester();
        }
      },
    );
  }
}
