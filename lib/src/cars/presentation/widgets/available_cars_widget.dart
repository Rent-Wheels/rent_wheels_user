import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/cars_loading.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/cars_info_sections.dart';

class AvailableCarsHome extends StatefulWidget {
  final bool? isNear;
  final bool isLoading;
  final List<Car> cars;
  final AvailableCarsType type;
  final void Function(int)? onTap;
  const AvailableCarsHome({
    super.key,
    this.onTap,
    this.isNear,
    required this.cars,
    required this.type,
    this.isLoading = true,
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
        if (widget.type == AvailableCarsType.preview)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (widget.isNear ?? false)
                    ? 'Vehicles Near You'
                    : 'Available Vehicles',
                style: theme.textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: rentWheelsInformationDark900,
                ),
              ),
              GestureDetector(
                onTap: () => context.pushReplacementNamed('allCars'),
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
            ? widget.type == AvailableCarsType.preview
                ? SizedBox(
                    height: Sizes().height(context, 0.35),
                    child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, _) => const CarsLoading(),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: Sizes().height(context, 0.28),
                        crossAxisSpacing: Sizes().width(context, 0.02),
                      ),
                      itemCount: 8,
                      shrinkWrap: true,
                      itemBuilder: (context, _) => const CarsLoading(),
                    ),
                  )
            : widget.cars.isNotEmpty
                ? widget.type == AvailableCarsType.preview
                    ? Column(
                        children: [
                          Space().height(context, 0.02),
                          SizedBox(
                            height: Sizes().height(context, 0.35),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.cars.length > 4
                                  ? 5
                                  : widget.cars.length,
                              itemBuilder: (context, index) {
                                return CarsInfoSections(
                                  onTap: widget.isLoading
                                      ? null
                                      : () => widget.onTap!(index),
                                  carDetails: widget.cars[index],
                                  width: Sizes().width(context, 0.6),
                                  margin: Sizes().width(context, 0.03),
                                  heroTag:
                                      '${(widget.isNear ?? false) ? 'near' : 'available'}-${widget.cars[index].registrationNumber}',
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: Sizes().height(context, 0.3),
                            crossAxisSpacing: Sizes().width(context, 0.02),
                          ),
                          itemCount: widget.cars.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(
                              top: Sizes().height(context, 0.02),
                            ),
                            child: CarsInfoSections(
                              carDetails: widget.cars[index],
                              width: Sizes().width(context, 0.5),
                              height: Sizes().height(context, 0.15),
                              onTap: widget.isLoading
                                  ? null
                                  : () => widget.onTap!(index),
                            ),
                          ),
                        ),
                      )
                : const SizedBox(),
      ],
    );
  }
}

enum AvailableCarsType { preview, allAvailableCars }
