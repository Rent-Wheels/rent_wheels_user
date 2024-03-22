import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';
import 'package:rent_wheels/assets/svgs/svg_constants.dart';
import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/carousel/image_carousel_slider_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/toast/toast_notification_widget.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/cars/presentation/bloc/cars_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/mainSection/base.dart';

import 'package:rent_wheels/src/mainSection/cars/data/available_cars_data.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/svg_icon_button_widgets.dart';
import 'package:rent_wheels/src/mainSection/home/data/available_cars_near_you_data.dart';
import 'package:rent_wheels/src/mainSection/home/widgets/promo_carousel_item_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _promoIndex = 0;
  final CarouselController _promo = CarouselController();
  final _carsBloc1 = sl<CarsBloc>();
  final _carsBloc2 = sl<CarsBloc>();

  String getLocationSuffix() {
    List<String> splitLocation = context
        .read<GlobalProvider>()
        .userDetails!
        .placeOfResidence!
        .split(', ');
    String place = splitLocation[splitLocation.length - 2];
    String country = splitLocation[splitLocation.length - 1];
    return '$place, $country';
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = [
      const PromoCarouselItem(
        label: 'Get up to 20% off your first ride',
        image: newUserPromoBannerImg,
      ),
      const PromoCarouselItem(
        label: 'New year 2023 25% off promo',
        image: newYearPromoBannerImg,
      ),
    ];

    return Scaffold(
        backgroundColor: rentWheelsNeutralLight0,
        body: Shimmer(
          linearGradient: global.shimmerGradient,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverAppBar(
                pinned: true,
                elevation: 0,
                backgroundColor: rentWheelsNeutralLight0,
                collapsedHeight: Sizes().height(context, 0.1),
                expandedHeight: Sizes().height(context, 0.13),
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  expandedTitleScale: 1,
                  titlePadding: const EdgeInsets.all(0),
                  title: Padding(
                    padding: EdgeInsets.only(
                      right: Sizes().width(context, 0.04),
                      left: Sizes().width(context, 0.04),
                      bottom: Sizes().height(context, 0.02),
                    ),
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
                                Text(
                                  'Your location',
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                    color: rentWheelsInformationDark900,
                                  ),
                                ),
                                Space().height(context, 0.003),
                                Text(
                                  getLocationSuffix(),
                                  style:
                                      theme.textTheme.headlineMedium!.copyWith(
                                    color: rentWheelsInformationDark900,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const SVGIconButton(
                                  svg: searchSVG,
                                  onPressed: buildToastNotification,
                                ),
                                Space().width(context, 0.07),
                                const SVGIconButton(
                                  svg: notificationsSVG,
                                  onPressed: buildToastNotification,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes().width(context, 0.04),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageCarouselSlider(
                            controller: _promo,
                            index: _promoIndex,
                            isPromotional: true,
                            height: Sizes().height(context, 0.37),
                            onPageChanged: (index, _) {
                              setState(() {
                                _promoIndex = index;
                              });
                            },
                            items: carouselItems,
                            autoPlay: carouselItems.length > 1,
                          ),
                          Space().height(context, 0.04),
                          // const AvailableCarsNearYouData(),
                          // Space().height(context, 0.04),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Available Vehicles',
                                style: theme.textTheme.headlineLarge!.copyWith(
                                  color: rentWheelsInformationDark900,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainSection(pageIndex: 1),
                                    ),
                                    (route) => false),
                                child: Text(
                                  'See all',
                                  style:
                                      theme.textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: rentWheelsNeutralDark900,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Space().height(context, 0.02),
                          // SizedBox(
                          //   height: Sizes().height(context, 0.35),
                          //   child: const AvailableCarsData(
                          //     type: AvailableCarsType.preview,
                          //   ),
                          // ),
                        ],
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
