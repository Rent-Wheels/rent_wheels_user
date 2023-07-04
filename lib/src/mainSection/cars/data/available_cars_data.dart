import 'package:flutter/material.dart';

import 'package:rent_wheels/core/models/enums/enums.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/cars/cars_data_widget.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AvailableCarsData extends StatefulWidget {
  final AvailableCarsType type;
  const AvailableCarsData({super.key, required this.type});

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
          return widget.type == AvailableCarsType.preview
              ? ListView.builder(
                  itemCount:
                      snapshot.data!.length > 4 ? 5 : snapshot.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildCarsData(
                      carDetails: snapshot.data![index],
                      isLoading: false,
                      context: context,
                      width: Sizes().width(context, 0.6),
                    );
                  })
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: snapshot.data!.map((car) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Sizes().height(context, 0.02),
                      ),
                      child: buildCarsData(
                        carDetails: car,
                        isLoading: false,
                        context: context,
                        width: double.infinity,
                      ),
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
        return widget.type == AvailableCarsType.preview
            ? ListView.builder(
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
              )
            : ListView.builder(
                itemCount: 5,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, _) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: Sizes().height(context, 0.02),
                    ),
                    child: ShimmerLoading(
                      isLoading: true,
                      child: buildCarsData(
                        isLoading: true,
                        context: context,
                        carDetails: Car(media: [Media(mediaURL: '')]),
                        width: double.infinity,
                      ),
                    ),
                  );
                },
              );
      },
    );
  }
}
