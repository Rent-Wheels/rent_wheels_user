import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/cars_info_sections.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class AvailableCarsHome extends StatefulWidget {
  final bool isNear;
  final bool isLoading;
  final List<Cars> cars;
  final void Function()? onTap;
  const AvailableCarsHome({
    super.key,
    this.onTap,
    required this.cars,
    required this.isNear,
    required this.isLoading,
  });
  @override
  State<AvailableCarsHome> createState() => _AvailableCarsHomeState();
}

class _AvailableCarsHomeState extends State<AvailableCarsHome> {
  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.isNear ? 'Vehicles Near You' : 'Available Vehicles',
              style: theme.textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: rentWheelsInformationDark900,
              ),
            ),
            GestureDetector(
              onTap: () => context.goNamed('allCars'),
              child: Text(
                'See all',
                style: theme.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: rentWheelsNeutralDark600,
                ),
              ),
            )
          ],
        ),
        Space().height(context, 0.02),
        widget.isLoading
            ? SizedBox(
                height: Sizes().height(context, 0.35),
                child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, _) {
                    return ShimmerLoading(
                      isLoading: true,
                      child: Container(
                        margin: EdgeInsets.only(
                          right: Sizes().width(context, 0.03),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: Sizes().height(context, 0.2),
                              width: Sizes().width(context, 0.6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  Sizes().height(context, 0.02),
                                ),
                                color: rentWheelsNeutralLight0,
                              ),
                            ),
                            Space().height(context, 0.01),
                            Container(
                              width: Sizes().width(context, 0.6),
                              height: Sizes().height(context, 0.02),
                              decoration: BoxDecoration(
                                color: rentWheelsNeutralLight0,
                                borderRadius: BorderRadius.circular(
                                  Sizes().height(context, 0.2),
                                ),
                              ),
                            ),
                            Space().height(context, 0.01),
                            Container(
                              width: Sizes().width(context, 0.2),
                              height: Sizes().height(context, 0.02),
                              decoration: BoxDecoration(
                                color: rentWheelsNeutralLight0,
                                borderRadius: BorderRadius.circular(
                                  Sizes().height(context, 0.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            : widget.cars.isNotEmpty
                ? Column(
                    children: [
                      Space().height(context, 0.02),
                      SizedBox(
                        height: Sizes().height(context, 0.35),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              widget.cars.length > 4 ? 5 : widget.cars.length,
                          itemBuilder: (context, index) {
                            return CarsInfoSections(
                              onTap: widget.onTap,
                              carDetails: widget.cars[index],
                              width: Sizes().width(context, 0.6),
                              margin: Sizes().width(context, 0.03),
                              heroTag:
                                  'near-${widget.cars[index].registrationNumber}',
                              // onTap: () async {
                              //   buildLoadingIndicator(context, '');
                              //   try {
                              //     final renter = await RentWheelsUserMethods()
                              //         .getRenterDetails(
                              //             userId: widget.cars[index].ownerId!);

                              //     if (!mounted) return;
                              //     context.pop();
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => CarDetails(
                              //           renter: renter,
                              //           car: widget.cars[index],
                              //           heroTag:
                              //               'near-${widget.cars[index].registrationNumber}',
                              //         ),
                              //       ),
                              //     );
                              //   } catch (e) {
                              //     if (!mounted) return;
                              //     context.pop();
                              //     showErrorPopUp(e.toString(), context);
                              //   }
                              // },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
      ],
    );

    //
  }
}
