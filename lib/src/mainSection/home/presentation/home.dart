import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/src/mainSection/home/widgets/promo_carousel_widget.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/svg_icon_button_widgets.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/promo_carousel_item_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _promoIndex = 0;
  final CarouselController _promo = CarouselController();

  String getLocationSuffix() {
    List<String> splitLocation =
        global.userDetails!.placeOfResidence.split(', ');
    String place = splitLocation[splitLocation.length - 2];
    String country = splitLocation[splitLocation.length - 1];
    return '$place, $country';
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = [
      buildPromoCarouselItem(
        label: 'Get up to 20% off your first ride',
        image: 'assets/images/new_user_promo_banner.jpeg',
        context: context,
      ),
      buildPromoCarouselItem(
        label: 'New year 2023 25% off promo',
        image: 'assets/images/new_year_promo_banner.jpg',
        context: context,
      ),
    ];

    return Scaffold(
        backgroundColor: rentWheelsNeutralLight0,
        body: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your location',
                        style: body1Information,
                      ),
                      Space().height(context, 0.003),
                      Text(
                        getLocationSuffix(),
                        style: heading4Information,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      buildSVGIconButton(
                        svg: 'assets/svgs/search.svg',
                        onPressed: () {},
                      ),
                      Space().width(context, 0.07),
                      buildSVGIconButton(
                        svg: 'assets/svgs/notifications.svg',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
              Space().height(context, 0.03),
              buildPromoCarousel(
                index: _promoIndex,
                context: context,
                controller: _promo,
                onPageChanged: (index, _) {
                  setState(() {
                    _promoIndex = index;
                  });
                },
                items: carouselItems,
              ),
            ],
          ),
        )
        // StreamBuilder(
        //   stream: RentWheelsCarsMethods().getAllAvailableCars(),
        //   builder: (context, snapshot) {
        // if (snapshot.hasData) {
        //   return AvailableCars(cars: snapshot.data!);
        // }
        // if (snapshot.hasError) {
        //   return Text(snapshot.error.toString());
        // }
        // return const CircularProgressIndicator();
        //   },
        // ),
        );
  }
}
