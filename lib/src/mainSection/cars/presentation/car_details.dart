import 'package:flutter/material.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/user/user_model.dart';
import 'package:rent_wheels/src/mainSection/renter/presentation/renter_profile.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  const CarDetails({super.key, required this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(widget.car.make!),
          GestureDetector(
              onTap: () async {
                BackendUser? renter = await RentWheelsUserMethods()
                    .getRenterDetails(userId: widget.car.owner!);

                if (!mounted) return;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RenterDetails(renter: renter),
                ));
              },
              child: const Text('Renter Details'))
        ],
      ),
    );
  }
}
