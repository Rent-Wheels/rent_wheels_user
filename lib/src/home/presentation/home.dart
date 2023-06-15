import 'package:flutter/material.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/src/cars/presentation/available_cars.dart';

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
        child: FutureBuilder(
          future: RentWheelsCarsMethods().getAllAvailableCars(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return snapshot.hasData
                    ? AvailableCars(cars: snapshot.data!)
                    : Text(snapshot.error.toString());
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}
