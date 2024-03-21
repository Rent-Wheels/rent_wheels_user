import 'package:flutter/material.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

mediaBottomSheet({
  required BuildContext context,
  required void Function() cameraOnTap,
  required void Function() galleryOnTap,
}) {
  return showModalBottomSheet(
    backgroundColor: rentWheelsNeutralLight0,
    context: context,
    builder: (context) => Container(
      height: Sizes().height(context, 0.2),
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(
          Sizes().height(context, 0.015),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //gallery
            ListTile(
              onTap: galleryOnTap,
              title: Text(
                'Gallery',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: rentWheelsInformationDark900,
                ),
              ),
              leading: const Icon(
                Icons.photo,
                color: rentWheelsBrandDark900,
              ),
            ),

            //camera
            ListTile(
              onTap: cameraOnTap,
              title: Text(
                'Camera',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: rentWheelsInformationDark900,
                ),
              ),
              leading: const Icon(
                Icons.camera,
                color: rentWheelsBrandDark900,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
