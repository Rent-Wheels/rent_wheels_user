import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/cars/cars_data_widget.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';

class AvailableCarsNearYouData extends StatefulWidget {
  const AvailableCarsNearYouData({super.key});

  @override
  State<AvailableCarsNearYouData> createState() =>
      _AvailableCarsNearYouDataState();
}

class _AvailableCarsNearYouDataState extends State<AvailableCarsNearYouData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RentWheelsCarsMethods().getAvailableCarsNearYou(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.map((car) {
              return buildCarsData(
                width: Sizes().width(context, 0.5),
                carDetails: car,
                context: context,
              );
            }).toList(),
          );
          // return buildCarsData(
          //   width: Sizes().width(context, 0.3),
          //   carDetails: snapshot!.data,
          //   context: context,
          // );
          // return AvailableCars(cars: snapshot.data!);
        }
        if (snapshot.hasError) {
          return const Text(
            'An error occured',
            style: heading3Error,
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
