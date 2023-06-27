import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

Future<dynamic> buildLoadingIndicator(
        BuildContext context, String loadingMessage) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: Sizes().height(context, 0.08),
                child: const LoadingIndicator(
                  indicatorType: Indicator.ballTrianglePathColored,
                  colors: [
                    rentWheelsBrandDark900,
                    rentWheelsBrand,
                    rentWheelsBrandLight100
                  ],
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),

            Space().height(context, 0.02),
            //message

            Center(
              child: DefaultTextStyle(
                style: body1NeutralLight,
                child: Text(
                  loadingMessage,
                ),
              ),
            )
          ],
        );
      },
    );
