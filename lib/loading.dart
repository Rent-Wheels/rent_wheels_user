import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rent_wheels/assets/images/image_constants.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      backgroundColor: const Color(0xff003f95),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Center(
              child: Image.asset(launchImg),
            ),
            Container(
              margin: EdgeInsets.only(bottom: Sizes().height(context, 0.05)),
              height: Sizes().height(context, 0.1),
              child: const LoadingIndicator(
                indicatorType: Indicator.ballTrianglePathColored,
                colors: [rentWheelsNeutralLight0],
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
