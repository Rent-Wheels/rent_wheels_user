import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/src/home/presentation/home.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('A verification email has been sent to ${global.user!.email} '),
          buildGenericButtonWidget(
              buttonName: 'Confirm Verification',
              onPressed: () async {
                await FirebaseAuth.instance.currentUser!.reload();

                global.user = FirebaseAuth.instance.currentUser;

                if (!global.user!.emailVerified) return;

                global.userDetails = await RentWheelsUserMethods()
                    .getUserDetails(userId: global.user!.uid);

                if (!mounted) return;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Home()),
                    (route) => false);
              }),
          buildGenericButtonWidget(
            buttonName: 'Resend Verification',
            onPressed: () async {
              await AuthService.firebase().verifyEmail(user: global.user!);
            },
          ),
        ],
      ),
    );
  }
}
