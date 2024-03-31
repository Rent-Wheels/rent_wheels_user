import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:rent_wheels/injection.dart';

import 'package:rent_wheels/assets/svgs/svg_constants.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';

import 'package:rent_wheels/core/enums/enums.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/error/error_message_widget.dart';
import 'package:rent_wheels/core/widgets/toast/toast_notification_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/carousel/image_carousel_slider_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/shimmer_loading_placeholder.dart';

import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/presentation/bloc/cars_bloc.dart';
import 'package:rent_wheels/src/renter/presentation/bloc/renter_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/cars/presentation/widgets/available_cars_widget.dart';
import 'package:rent_wheels/src/home/presentation/widgets/svg_icon_button_widgets.dart';
import 'package:rent_wheels/src/home/presentation/widgets/promo_carousel_item_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Car? _car;
  int _promoIndex = 0;
  final _carsBloc1 = sl<CarsBloc>();
  final _carsBloc2 = sl<CarsBloc>();
  final _renterBloc = sl<RenterBloc>();
  final CarouselController _promo = CarouselController();

  final List<Widget> carouselItems = [
    const PromoCarouselItem(
      label: 'Get up to 20% off your first ride',
      image: newUserPromoBannerImg,
    ),
    const PromoCarouselItem(
      label: 'New year 2023 25% off promo',
      image: newYearPromoBannerImg,
    ),
  ];

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

  getAllCars() {
    final nearParams = {
      'queryParameters': {
        'location': getLocationSuffix(),
      },
      'headers': context.read<GlobalProvider>().headers,
    };
    final allParams = {
      'headers': context.read<GlobalProvider>().headers,
    };

    _carsBloc1.add(GetAllAvailableCarsEvent(params: nearParams));
    _carsBloc2.add(GetAllAvailableCarsEvent(params: allParams));
  }

  getRenterDetails(bool isNear) {
    buildLoadingIndicator(context, '');
    final params = {
      'isNear': isNear,
      'urlParameters': {
        'renterId': _car!.ownerId,
      },
      'headers': context.read<GlobalProvider>().headers,
    };

    _renterBloc.add(GetRenterDetailsEvent(params: params));
  }

  @override
  void initState() {
    getAllCars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer(
        linearGradient: context.read<GlobalProvider>().shimmerGradient,
        child: BlocListener(
          bloc: _renterBloc,
          listener: (context, state) {
            if (state is GenericRenterError) {
              context.pop();
              showErrorPopUp(state.errorMessage, context);
            }

            if (state is GetRenterDetailsLoaded) {
              context.pop();
              context.pushNamed(
                'carDetails',
                pathParameters: {
                  'carId': _car!.id!,
                },
                queryParameters: {
                  'car': jsonEncode(_car!.toMap()),
                  'renter': jsonEncode(state.renter.toMap()),
                  'heroTag':
                      '${(state.isNear ?? false) ? 'near' : 'available'}-${_car!.registrationNumber}'
                },
              );
            }
          },
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
                      left: Sizes().width(context, 0.04),
                      right: Sizes().width(context, 0.04),
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
                          BlocBuilder(
                            bloc: _carsBloc1,
                            builder: (context, state) {
                              if (state is GetAllAvailableCarsLoaded) {
                                return AvailableCarsHome(
                                  isNear: true,
                                  cars: state.cars,
                                  isLoading: false,
                                  type: AvailableCarsType.preview,
                                  onTap: (p0) {
                                    setState(() {
                                      _car = state.cars[p0];
                                    });
                                    getRenterDetails(true);
                                  },
                                );
                              }

                              if (state is GenericCarsError) {
                                return ErrorMessage(
                                  label: 'An error occured',
                                  errorMessage: state.errorMessage,
                                );
                              }
                              return const AvailableCarsHome(
                                cars: [],
                                isNear: true,
                                type: AvailableCarsType.preview,
                              );
                            },
                          ),
                          BlocBuilder(
                            bloc: _carsBloc2,
                            builder: (context, state) {
                              if (state is GetAllAvailableCarsLoaded) {
                                return AvailableCarsHome(
                                  isNear: false,
                                  cars: state.cars,
                                  isLoading: false,
                                  type: AvailableCarsType.preview,
                                  onTap: (p0) {
                                    setState(() {
                                      _car = state.cars[p0];
                                    });
                                    getRenterDetails(false);
                                  },
                                );
                              }

                              if (state is GenericCarsError) {
                                return ErrorMessage(
                                  label: 'An error occured',
                                  errorMessage: state.errorMessage,
                                );
                              }
                              return const AvailableCarsHome(
                                cars: [],
                                isNear: false,
                                isLoading: true,
                                type: AvailableCarsType.preview,
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}