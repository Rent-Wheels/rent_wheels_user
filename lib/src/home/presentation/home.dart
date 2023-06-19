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
