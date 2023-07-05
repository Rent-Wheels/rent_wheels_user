import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

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
  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Hero(
            tag: widget.car.media![0].mediaURL,
            createRectTween: _createRectTween,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: Sizes().height(context, 0.3),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: rentWheelsNeutralLight0,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      '${global.baseURL}/${widget.car.media![0].mediaURL}',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(widget.car.make!),
          GestureDetector(
              onTap: () async {
                BackendUser? renter = await RentWheelsUserMethods()
                    .getRenterDetails(userId: widget.car.owner!);

                if (!mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RenterDetails(renter: renter),
                    ));
              },
              child: const Text('Renter Details'))
        ],
      ),
    );
  }
}
