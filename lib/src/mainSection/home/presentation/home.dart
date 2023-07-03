import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/src/mainSection/cars/data/available_cars_data.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/promo_carousel_widget.dart';
import 'package:rent_wheels/src/mainSection/home/data/available_cars_near_you_data.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/promo_carousel_item_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/svg_icon_button_widgets.dart';

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

  final _shimmerGradient = const LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

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
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: rentWheelsNeutralLight0,
        //   foregroundColor: rentWheelsInformationDark900,
        //   title: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       const Text(
        //         'Your location',
        //         style: body1Information,
        //       ),
        //       Space().height(context, 0.003),
        //       Text(
        //         getLocationSuffix(),
        //         style: heading4Information,
        //       ),
        //     ],
        //   ),
        //   actions: [
        //     buildSVGIconButton(
        //       svg: 'assets/svgs/search.svg',
        //       onPressed: () {},
        //     ),
        //     Space().width(context, 0.07),
        //     buildSVGIconButton(
        //       svg: 'assets/svgs/notifications.svg',
        //       onPressed: () {},
        //     ),
        //   ],
        // ),
        body: Shimmer(
          linearGradient: _shimmerGradient,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: rentWheelsNeutralLight0,
                elevation: 0,
                collapsedHeight: Sizes().height(context, 0.07),
                expandedHeight: Sizes().height(context, 0.13),
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Sizes().height(context, 0.02)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
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
                      ],
                    ),
                  ),
                  expandedTitleScale: 1,
                  centerTitle: true,
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 1,
                      (context, index) {
                return Padding(
                  padding: EdgeInsets.all(Sizes().height(context, 0.02)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Space().height(context, 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Vehicles Near You',
                            style: heading4Information,
                          ),
                          GestureDetector(
                            child: const Text(
                              'See all',
                              style: heading6Neutral500,
                            ),
                          )
                        ],
                      ),
                      Space().height(context, 0.02),
                      SizedBox(
                        height: Sizes().height(context, 0.27),
                        child: const AvailableCarsNearYouData(),
                      ),
                      Space().height(context, 0.04),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Available Vehicles',
                            style: heading4Information,
                          ),
                          GestureDetector(
                            child: const Text(
                              'See all',
                              style: heading6Neutral500,
                            ),
                          )
                        ],
                      ),
                      Space().height(context, 0.02),
                      SizedBox(
                        height: Sizes().height(context, 0.27),
                        child: const AvailableCarsData(),
                      ),
                    ],
                  ),
                );
              }))
            ],
          ),
        ));
  }
}
