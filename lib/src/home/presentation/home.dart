import 'package:flutter/material.dart';
import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/src/login/presentation/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: StreamBuilder(
        stream: RentWheelsCarsMethods().getAllAvailableCars(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                buildGenericButtonWidget(
                  buttonName: 'Login',
                  onPressed: () async {
                    await AuthService.firebase().signInWithEmailAndPassword(
                        email: global.user!.email, password: 'password');
                  },
                ),
                buildGenericButtonWidget(
                    buttonName: 'Delete Account',
                    onPressed: () async {
                      await AuthService.firebase()
                          .deleteUser(user: global.user!);
                      if (!mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                          (route) => false);
                    }),
              ],
            );
            // return AvailableCars(cars: snapshot.data!);
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
