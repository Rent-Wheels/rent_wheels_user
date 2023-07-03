import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/cars/cars_data_widget.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AvailableCarsData extends StatefulWidget {
  const AvailableCarsData({super.key});

  @override
  State<AvailableCarsData> createState() => _AvailableCarsDataState();
}

class _AvailableCarsDataState extends State<AvailableCarsData> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: RentWheelsCarsMethods().getAllAvailableCars(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.map((car) {
              return buildCarsData(
                carDetails: car,
                isLoading: false,
                context: context,
                width: Sizes().width(context, 0.6),
              );
            }).toList(),
          );
        }
        if (snapshot.hasError) {
          return const Text(
            'An error occured',
            style: heading3Error,
          );
        }
        return ListView.builder(
          itemCount: 2,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, _) {
            return ShimmerLoading(
              isLoading: true,
              child: buildCarsData(
                isLoading: true,
                context: context,
                carDetails: Car(media: [Media(mediaURL: '')]),
                width: Sizes().width(context, 0.6),
              ),
            );
          },
        );
      },
    );
  }
}
