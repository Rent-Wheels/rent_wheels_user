import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/src/mainSection/cars/widgets/car_details_carousel.dart';
import 'package:rent_wheels/src/mainSection/cars/widgets/car_details_carousel_items.dart';

import 'package:rent_wheels/src/mainSection/renter/presentation/renter_profile.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/models/user/user_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';

class CarDetails extends StatefulWidget {
  final Car car;
  const CarDetails({super.key, required this.car});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int _carImageIndex = 0;
  bool changeColor = false;

  final ScrollController scroll = ScrollController();
  final CarouselController _carImage = CarouselController();

  @override
  void initState() {
    scroll.addListener(() {
      setState(() {
        if (scroll.offset < 196) {
          changeColor = false;
        } else {
          changeColor = true;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> carouselItems = widget.car.media!.map((media) {
      return buildCarDetailsCarouselItem(
          image: '${global.baseURL}/${media.mediaURL}', context: context);
    }).toList();
    return Scaffold(
        backgroundColor: rentWheelsNeutralLight0,
        body: CustomScrollView(
          controller: scroll,
          slivers: [
            SliverAppBar(
              backgroundColor: rentWheelsNeutralLight0,
              foregroundColor: !changeColor
                  ? rentWheelsNeutralLight0
                  : rentWheelsBrandDark900,
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
                      tag: widget.car.media![0].mediaURL,
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
                        // Container(
                        //   height: Sizes().height(context, 0.3),
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: rentWheelsNeutralLight0,
                        //     image: DecorationImage(
                        //       fit: BoxFit.cover,
                        //       image: CachedNetworkImageProvider(
                        //         '${global.baseURL}/${widget.car.media![0].mediaURL}',
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                // childCount: 1,
                (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.car.make!),
                      GestureDetector(
                          onTap: () async {
                            BackendUser? renter = await RentWheelsUserMethods()
                                .getRenterDetails(userId: widget.car.owner!);

                            if (!mounted) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RenterDetails(renter: renter),
                                ));
                          },
                          child: const Text('Renter Details'))
                    ],
                  );
                },
              ),
            ),
          ],
        ));
  }
}
