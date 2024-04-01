import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/renter/data/models/renter_model.dart';

import 'package:rent_wheels/src/renter/presentation/widgets/renter_cars_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';

class RenterDetails extends StatefulWidget {
  final String renter;
  const RenterDetails({super.key, required this.renter});

  @override
  State<RenterDetails> createState() => _RenterDetailsState();
}

class _RenterDetailsState extends State<RenterDetails> {
  Renter? _renter;
  @override
  void initState() {
    _renter = RenterModel.fromJSON(jsonDecode(widget.renter));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: rentWheelsNeutralLight0,
        appBar: AppBar(
          backgroundColor: rentWheelsNeutralLight0,
          foregroundColor: rentWheelsBrandDark900,
          elevation: 0,
          leading: AdaptiveBackButton(
            onPressed: () => context.pop(),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes().width(context, 0.04),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Sizes().width(context, 0.9),
                height: Sizes().height(context, 0.35),
                padding: EdgeInsets.all(Sizes().height(context, 0.01)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Sizes().height(context, 0.015),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: Sizes().width(context, 0.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _renter!.name!,
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: rentWheelsInformationDark900,
                            ),
                          ),
                          Space().height(context, 0.01),
                          Text(
                            'Email',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: rentWheelsNeutral,
                            ),
                          ),
                          Space().height(context, 0.01),
                          Text(
                            _renter!.email!,
                            style: theme.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: rentWheelsInformationDark900,
                            ),
                          ),
                          Space().height(context, 0.01),
                          Text(
                            'Phone Number',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: rentWheelsNeutral,
                            ),
                          ),
                          Space().height(context, 0.01),
                          Text(
                            _renter!.phoneNumber!,
                            style: theme.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: rentWheelsInformationDark900,
                            ),
                          ),
                          Space().height(context, 0.01),
                          Text(
                            'Location',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color: rentWheelsNeutral,
                            ),
                          ),
                          Space().height(context, 0.01),
                          Text(
                            _renter!.placeOfResidence!,
                            style: theme.textTheme.headlineMedium!.copyWith(
                              fontWeight: FontWeight.w500,
                              color: rentWheelsInformationDark900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: Sizes().width(context, 0.45),
                      height: Sizes().height(context, 0.2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          Sizes().height(context, 0.015),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            _renter!.profilePicture!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Cars',
                style: theme.textTheme.titleSmall!.copyWith(
                  color: rentWheelsInformationDark900,
                ),
              ),
              Space().height(context, 0.02),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: Sizes().height(context, 0.24),
                    crossAxisSpacing: Sizes().width(context, 0.02),
                  ),
                  itemCount: _renter!.cars!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RenterCars(
                      width: Sizes().width(context, 0.5),
                      carDetails: _renter!.cars![index],
                      onTap: () => context.pushNamed(
                        'carDetails',
                        pathParameters: {
                          'carId': _renter!.cars![index].id!,
                        },
                        queryParameters: {
                          'car': jsonEncode(_renter!.cars![index].toMap()),
                          'renter': jsonEncode(_renter!.toMap()),
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
