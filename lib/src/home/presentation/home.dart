import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rent_wheels/src/login/presentation/login.dart';
import 'package:rent_wheels/src/cars/presentation/available_cars.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes().height(context, 0.01)),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: rentWheelsErrorDark700,
              ),
              onPressed: () async {
                buildLoadingIndicator(context, 'Logging Out');

                try {
                  await AuthService.firebase().logout();
                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      CupertinoPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false);
                } catch (e) {
                  if (!mounted) return;
                  Navigator.pop(context);
                  showErrorPopUp(e.toString(), context);
                }
              },
            ),
          )
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
        stream: RentWheelsCarsMethods().getAllAvailableCars(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return AvailableCars(cars: snapshot.data!);
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return const CircularProgressIndicator();
        },
      )),
    );
  }
}
