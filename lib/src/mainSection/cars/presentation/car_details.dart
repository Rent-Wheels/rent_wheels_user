import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/src/mainSection/cars/widgets/car_details_carousel.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels/src/mainSection/renter/presentation/renter_profile.dart';
import 'package:rent_wheels/src/mainSection/cars/widgets/renter_overview_widget.dart';
import 'package:rent_wheels/src/mainSection/cars/widgets/car_details_carousel_items.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/src/mainSection/reservations/presentation/booking/make_reservation_page_one.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  final Renter renter;
  final String? heroTag;

  const CarDetails(
      {super.key, required this.car, required this.renter, this.heroTag});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int _carImageIndex = 0;
  bool changeColor = false;

  final ScrollController scroll = ScrollController();
  final CarouselController _carImage = CarouselController();

  @override
  Widget build(BuildContext context) {
    scroll.addListener(() {
      if (scroll.offset < 196) {
        setState(() {
          changeColor = false;
        });
      } else {
        setState(() {
          changeColor = true;
        });
      }
    });
    Car car = widget.car;
    List<Widget> carouselItems = widget.car.media!.map((media) {
      return buildCarDetailsCarouselItem(
          image: media.mediaURL, context: context);
    }).toList();

    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          SliverAppBar(
            backgroundColor: rentWheelsNeutralLight0,
            foregroundColor:
                !changeColor ? rentWheelsNeutralLight0 : rentWheelsBrandDark900,
            elevation: 0,
            leading: buildAdaptiveBackButton(
              onPressed: () => Navigator.pop(context),
            ),
            pinned: true,
            expandedHeight: Sizes().height(context, 0.3),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Hero(
                    tag: widget.heroTag ?? car.media![0].mediaURL,
                    child: GestureDetector(
                      // onTap: () => Navigator.pop(context),
                      child: buildCarImageCarousel(
                        index: _carImageIndex,
                        items: carouselItems,
                        context: context,
                        controller: _carImage,
                        onPageChanged: (index, _) {
                          setState(() {
                            _carImageIndex = index;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: Sizes().width(context, 0.04),
                    right: Sizes().width(context, 0.04),
                    top: Sizes().height(context, 0.01),
                    bottom: Sizes().width(context, 0.3),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${car.yearOfManufacture} ${car.make} ${car.model}',
                        style: heading3Information,
                      ),
                      Space().height(context, 0.01),
                      Text(
                        car.description!,
                        style: body1Neutral900,
                      ),
                      Space().height(context, 0.02),
                      const Text(
                        'Vehicle Details',
                        style: heading4Information,
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Registration Number',
                        value: car.registrationNumber!,
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Color',
                        value: car.color!,
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Number of Seats',
                        value: car.capacity.toString(),
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Type',
                        value: car.type!,
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Condition',
                        value: car.condition!,
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Maximum Rental Duration',
                        value: '${car.maxDuration!} ${car.durationUnit!}',
                      ),
                      Space().height(context, 0.01),
                      buildDetailsKeyValue(
                        context: context,
                        label: 'Location',
                        value: car.location!,
                      ),
                      Space().height(context, 0.02),
                      const Text(
                        'Terms & Conditions',
                        style: heading4Information,
                      ),
                      Space().height(context, 0.01),
                      Text(
                        car.terms!,
                        style: body1Neutral900,
                      ),
                      Space().height(context, 0.02),
                      const Text(
                        'Renter Details',
                        style: heading4Information,
                      ),
                      Space().height(context, 0.01),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) =>
                                  RenterDetails(renter: widget.renter),
                            ),
                          );
                        },
                        child: buildRenterOverview(
                          context: context,
                          renter: widget.renter,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: rentWheelsNeutralLight0,
        padding: EdgeInsets.all(Sizes().height(context, 0.02)),
        height: Sizes().height(context, 0.13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${car.yearOfManufacture} ${car.make} ${car.model}',
                  style: heading4Information,
                ),
                Space().height(context, 0.01),
                Text(
                  'GH¢${car.rate} ${car.plan}',
                  style: body1Information,
                ),
              ],
            ),
            buildGenericButtonWidget(
              width: Sizes().width(context, 0.28),
              isActive: car.availability!,
              buttonName: 'Reserve Car',
              context: context,
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MakeReservationPageOne(car: car),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
