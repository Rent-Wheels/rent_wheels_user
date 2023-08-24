import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/src/mainSection/cars/presentation/car_details.dart';
import 'package:rent_wheels/src/mainSection/renter/widgets/renter_cars_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

class RenterDetails extends StatelessWidget {
  final Renter renter;
  const RenterDetails({super.key, required this.renter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: rentWheelsNeutralLight0,
        appBar: AppBar(
          backgroundColor: rentWheelsNeutralLight0,
          foregroundColor: rentWheelsBrandDark900,
          elevation: 0,
          leading: buildAdaptiveBackButton(
            onPressed: () => Navigator.pop(context),
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
                            renter.name!,
                            style: heading3Information,
                          ),
                          Space().height(context, 0.01),
                          const Text(
                            'Email',
                            style: body1Neutral500,
                          ),
                          Space().height(context, 0.01),
                          Text(
                            renter.email!,
                            style: heading5Information500,
                          ),
                          Space().height(context, 0.01),
                          const Text(
                            'Phone Number',
                            style: body1Neutral500,
                          ),
                          Space().height(context, 0.01),
                          Text(
                            renter.phoneNumber!,
                            style: heading5Information500,
                          ),
                          Space().height(context, 0.01),
                          const Text(
                            'Location',
                            style: body1Neutral500,
                          ),
                          Space().height(context, 0.01),
                          Text(
                            renter.placeOfResidence!,
                            style: heading5Information500,
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
                            renter.profilePicture!,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'Cars',
                style: heading3Information,
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
                  itemCount: renter.cars!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildRenterCars(
                      width: Sizes().width(context, 0.5),
                      carDetails: renter.cars![index],
                      context: context,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarDetails(
                            car: renter.cars![index],
                            renter: renter,
                          ),
                        ),
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
