import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';

mediaBottomSheet({
  required BuildContext context,
  required void Function() cameraOnTap,
  required void Function() galleryOnTap,
}) {
  return showBarModalBottomSheet(
    backgroundColor: rentWheelsNeutralLight0,
    context: context,
    builder: (context) {
      return Container(
        height: Sizes().height(context, 0.2),
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.015)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //gallery
              ListTile(
                onTap: galleryOnTap,
                title: const Text(
                  'Gallery',
                  style: heading5Information,
                ),
                leading: const Icon(
                  Icons.photo,
                  color: rentWheelsBrandDark900,
                ),
              ),

              //camera
              ListTile(
                onTap: cameraOnTap,
                title: const Text(
                  'Camera',
                  style: heading5Information,
                ),
                leading: const Icon(
                  Icons.camera,
                  color: rentWheelsBrandDark900,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
