import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/mainSection/base.dart';

import 'package:rent_wheels/src/mainSection/cars/presentation/car_details.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/cars_info_sections.dart';
import 'package:rent_wheels/core/backend/car/methods/cars_methods.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
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
          return snapshot.data!.isNotEmpty
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Vehicles Near You',
                          style: theme.textTheme.headlineLarge!.copyWith(
                            color: rentWheelsInformationDark900,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MainSection(pageIndex: 1),
                              ),
                              (route) => false),
                          child: Text(
                            'See all',
                            style: theme.textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: rentWheelsNeutralDark900,
                            ),
                          ),
                        )
                      ],
                    ),
                    Space().height(context, 0.02),
                    SizedBox(
                      height: Sizes().height(context, 0.35),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length > 4
                            ? 5
                            : snapshot.data!.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CarsInfoSections(
                            isLoading: false,
                            carDetails: snapshot.data![index],
                            width: Sizes().width(context, 0.6),
                            margin: Sizes().width(context, 0.03),
                            heroTag:
                                'near-${snapshot.data![index].registrationNumber}',
                            onTap: () async {
                              buildLoadingIndicator(context, '');
                              try {
                                final renter = await RentWheelsUserMethods()
                                    .getRenterDetails(
                                        userId: snapshot.data![index].owner!);

                                if (!mounted) return;
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CarDetails(
                                      renter: renter,
                                      car: snapshot.data![index],
                                      heroTag:
                                          'near-${snapshot.data![index].registrationNumber}',
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
                      ),
                    ),
                  ],
                )
              : const SizedBox();
        }
        if (snapshot.hasError) {
          return const ErrorMessage(
            label: 'An error occured',
            errorMessage: 'Please check your internet connection.',
          );
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vehicles Near You',
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainSection(pageIndex: 1),
                      ),
                      (route) => false),
                  child: Text(
                    'See all',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: rentWheelsNeutralDark900,
                    ),
                  ),
                )
              ],
            ),
            Space().height(context, 0.02),
            SizedBox(
              height: Sizes().height(context, 0.35),
              child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, _) {
                  return ShimmerLoading(
                    isLoading: true,
                    child: CarsInfoSections(
                      margin: Sizes().width(context, 0.03),
                      isLoading: true,
                      carDetails: Car(media: [Media(mediaURL: '')]),
                      width: Sizes().width(context, 0.6),
                      onTap: null,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
