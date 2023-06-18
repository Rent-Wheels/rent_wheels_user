import 'package:flutter/material.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/src/cars/presentation/car_details.dart';

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
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CarDetails(car: cars[index]),
              ));
            },
            child: ListTile(
              title: Text(
                  "${cars[index].yearOfManufacture} ${cars[index].make} ${cars[index].model}"),
            ),
          );
        },
      ),
    );
  }
}
