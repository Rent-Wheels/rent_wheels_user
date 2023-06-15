import 'package:flutter/material.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';

class AvailableCars extends StatefulWidget {
  final List<Car> cars;
  const AvailableCars({super.key, required this.cars});

  @override
  State<AvailableCars> createState() => _AvailableCarsState();
}

class _AvailableCarsState extends State<AvailableCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.cars.length,
        itemBuilder: (context, index) {
          List<Car> cars = widget.cars;
          return ListTile(
            title: Text(cars[index].make),
          );
        },
      ),
    );
  }
}
