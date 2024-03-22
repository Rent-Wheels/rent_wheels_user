import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/carousel/image_carousel_slider_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';

import 'package:rent_wheels/src/mainSection/renter/presentation/renter_profile.dart';
import 'package:rent_wheels/src/mainSection/cars/widgets/renter_overview_widget.dart';
import 'package:rent_wheels/src/mainSection/cars/widgets/car_details_carousel_items.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/models/renter/renter_model.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
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
    List<Widget> carouselItems = car.media!.map((media) {
      return CarDetailsCarouselItem(image: media.mediaURL);
    }).toList();

    // final List<ImageProvider> carImages = car.media!
    //     .map((media) => CachedNetworkImageProvider(media.mediaURL))
    //     .toList();

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
            leading: AdaptiveBackButton(
              onPressed: () => context.pop(),
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
                      child: ImageCarouselSlider(
                        index: _carImageIndex,
                        items: carouselItems,
                        controller: _carImage,
                        autoPlay: false,
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
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: rentWheelsInformationDark900,
                        ),
                      ),
                      Space().height(context, 0.01),
                      Text(
                        car.description!,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: rentWheelsNeutralDark900,
                        ),
                      ),
                      Space().height(context, 0.02),
                      Text(
                        'Vehicle Details',
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: rentWheelsInformationDark900,
                        ),
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Registration Number',
                        value: car.registrationNumber!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Color',
                        value: car.color!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Number of Seats',
                        value: car.capacity.toString(),
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Type',
                        value: car.type!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Condition',
                        value: car.condition!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Maximum Rental Duration',
                        value: '${car.maxDuration!} ${car.durationUnit!}',
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Location',
                        value: car.location!,
                      ),
                      Space().height(context, 0.02),
                      Text(
                        'Terms & Conditions',
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: rentWheelsInformationDark900,
                        ),
                      ),
                      Space().height(context, 0.01),
                      Text(
                        car.terms!,
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: rentWheelsNeutralDark900,
                        ),
                      ),
                      Space().height(context, 0.02),
                      Text(
                        'Renter Details',
                        style: theme.textTheme.headlineLarge!.copyWith(
                          color: rentWheelsInformationDark900,
                        ),
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
                        child: RenterOverview(
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
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.01),
                Text(
                  'GH¢${car.rate} ${car.plan}',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
              ],
            ),
            GenericButton(
              width: Sizes().width(context, 0.28),
              isActive: car.availability!,
              buttonName: 'Reserve Car',
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
