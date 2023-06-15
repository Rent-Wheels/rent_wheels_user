import 'package:flutter/material.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/src/home/presentation/home.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/src/signup/presentation/signup.dart';
import 'package:rent_wheels/src/verify/presentation/verify_email.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Email'),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(hintText: 'Password'),
          ),
          buildGenericButtonWidget(
              buttonName: 'Login',
              onPressed: () async {
                final credential =
                    await AuthService.firebase().signInWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );

                global.setGlobals(currentUser: credential.user!);

                if (!mounted) return;

                if (!global.user!.emailVerified) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const VerifyEmail(),
                    ),
                  );
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const Home()),
                      (route) => false);
                }
              }),
          buildGenericButtonWidget(
            buttonName: 'Sign Up',
            onPressed: () {
              if (!mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SignUp(),
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
