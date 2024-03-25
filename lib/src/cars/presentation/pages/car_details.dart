import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/carousel/image_carousel_slider_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/src/cars/data/models/cars_model.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';

import 'package:rent_wheels/src/renter/data/models/renter_model.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';
import 'package:rent_wheels/src/renter/presentation/widgets/renter_overview_widget.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/car_details_carousel_items.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/details/key_value_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/src/reservations/presentation/pages/make_reservation_page_one.dart';

class CarDetails extends StatefulWidget {
  final String car;
  final String renter;
  final String? heroTag;

  const CarDetails({
    super.key,
    required this.car,
    required this.renter,
    this.heroTag,
  });

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  Car? _car;
  Renter? _renter;

  int _carImageIndex = 0;
  bool changeColor = false;

  final ScrollController scroll = ScrollController();
  final CarouselController _carImage = CarouselController();

  parseData() {
    _car = CarModel.fromJSON(jsonDecode(widget.car));
    _renter = RenterModel.fromJSON(jsonDecode(widget.renter));
  }

  @override
  void initState() {
    parseData();
    super.initState();
  }

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

    List<Widget> carouselItems = _car!.media!.map((media) {
      return CarDetailsCarouselItem(image: media.mediaURL!);
    }).toList();

    // final List<ImageProvider> carImages = _car!.media!
    //     .map((media) => CachedNetworkImageProvider(media.mediaURL))
    //     .toList();

    return Scaffold(
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
                    tag: widget.heroTag ?? _car!.media![0].mediaURL!,
                    child: GestureDetector(
                      child: ImageCarouselSlider(
                        isPromotional: false,
                        items: carouselItems,
                        controller: _carImage,
                        index: _carImageIndex,
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
                        '${_car!.yearOfManufacture} ${_car!.make} ${_car!.model}',
                        style: theme.textTheme.titleSmall!.copyWith(
                          color: rentWheelsInformationDark900,
                        ),
                      ),
                      Space().height(context, 0.01),
                      Text(
                        _car!.description!,
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
                        value: _car!.registrationNumber!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Color',
                        value: _car!.color!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Number of Seats',
                        value: _car!.capacity.toString(),
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Type',
                        value: _car!.type!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Condition',
                        value: _car!.condition!,
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Maximum Rental Duration',
                        value: '${_car!.maxDuration!} ${_car!.durationUnit!}',
                      ),
                      Space().height(context, 0.01),
                      DetailsKeyValue(
                        label: 'Location',
                        value: _car!.location!,
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
                        _car!.terms!,
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
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     CupertinoPageRoute(
                        //       builder: (context) =>
                        //           RenterDetails(renter: _renter),
                        //     ),
                        //   );
                        // },
                        child: RenterOverview(
                          renter: _renter!,
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
                  '${_car!.yearOfManufacture} ${_car!.make} ${_car!.model}',
                  style: theme.textTheme.headlineLarge!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.01),
                Text(
                  'GH¢${_car!.rate} ${_car!.plan}',
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
              ],
            ),
            GenericButton(
              width: Sizes().width(context, 0.28),
              isActive: _car!.availability!,
              buttonName: 'Reserve Car',
              onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MakeReservationPageOne(car: _car),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
