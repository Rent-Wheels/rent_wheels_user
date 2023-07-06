import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:rent_wheels/src/mainSection/cars/presentation/car_details.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/cars/cars_data_widget.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AvailableCarsNearYouData extends StatefulWidget {
  const AvailableCarsNearYouData({super.key});

  @override
  State<AvailableCarsNearYouData> createState() =>
      _AvailableCarsNearYouDataState();
}

class _AvailableCarsNearYouDataState extends State<AvailableCarsNearYouData> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return StreamBuilder(
      stream: RentWheelsCarsMethods().getAvailableCarsNearYou(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length > 4 ? 5 : snapshot.data!.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return buildCarsData(
                margin: Sizes().width(context, 0.03),
                carDetails: snapshot.data![index],
                isLoading: false,
                context: context,
                width: Sizes().width(context, 0.6),
                onTap: () async {
                  buildLoadingIndicator(context, '');
                  try {
                    final renter = await RentWheelsUserMethods()
                        .getRenterDetails(userId: snapshot.data![index].owner!);

                    if (!mounted) return;
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarDetails(
                          car: snapshot.data![index],
                          renter: renter,
                        ),
                      ),
                    );
                  } catch (e) {
                    if (!mounted) return;
                    Navigator.pop(context);
                    showErrorPopUp(e.toString(), context);
                  }
                },
              );
            },
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
          shrinkWrap: true,
          itemBuilder: (context, _) {
            return ShimmerLoading(
              isLoading: true,
              child: buildCarsData(
                margin: Sizes().width(context, 0.03),
                isLoading: true,
                context: context,
                carDetails: Car(media: [Media(mediaURL: '')]),
                width: Sizes().width(context, 0.6),
                onTap: null,
              ),
            );
          },
        );
      },
    );
  }
}
