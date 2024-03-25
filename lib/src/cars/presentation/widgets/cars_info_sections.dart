import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';

class CarsInfoSections extends StatefulWidget {
  final double width;
  final double? margin;
  final double? height;
  final String? heroTag;
  final Car? carDetails;
  final void Function()? onTap;

  const CarsInfoSections({
    super.key,
    this.margin,
    this.height,
    this.heroTag,
    required this.width,
    required this.onTap,
    required this.carDetails,
  });

  @override
  State<CarsInfoSections> createState() => _CarsInfoSectionsState();
}

class _CarsInfoSectionsState extends State<CarsInfoSections> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        margin: EdgeInsets.only(
          right: widget.margin ?? 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag:
                  widget.heroTag ?? widget.carDetails?.media![0].mediaURL ?? '',
              child: Container(
                height: widget.height ?? Sizes().height(context, 0.2),
                width: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes().height(context, 0.02),
                  ),
                  color: rentWheelsNeutralLight0,
                  image: widget.carDetails?.media![0].mediaURL == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            widget.carDetails!.media![0].mediaURL!,
                          ),
                        ),
                ),
              ),
            ),
            Space().height(context, 0.01),
            Text(
              '${widget.carDetails!.yearOfManufacture} ${widget.carDetails!.make} ${widget.carDetails!.model}',
              style: theme.textTheme.headlineLarge!.copyWith(
                color: rentWheelsInformationDark900,
              ),
            ),
            Space().height(context, 0.01),
            Text(
              'GH¢${widget.carDetails!.rate} ${widget.carDetails!.plan}',
              style: theme.textTheme.bodyLarge!.copyWith(
                color: rentWheelsInformationDark900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
