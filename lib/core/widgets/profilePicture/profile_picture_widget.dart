import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';

buildProfilePicture({
  required BuildContext context,
  File? imageFile,
  String? imgUrl,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Center(
      child: SizedBox(
        width: Sizes().width(context, 0.35),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Container(
                height: Sizes().height(context, 0.15),
                width: Sizes().width(context, 0.3),
                decoration: BoxDecoration(
                  image: imageFile != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(imageFile),
                        )
                      : imgUrl != null
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(imgUrl),
                            )
                          : null,
                  border: Border.all(color: rentWheelsNeutralLight200),
                  color: rentWheelsNeutralLight0,
                  borderRadius: BorderRadius.circular(
                    Sizes().height(context, 0.015),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: Sizes().width(context, 0.035),
                backgroundColor: rentWheelsNeutralLight0,
                child: Icon(
                  Icons.camera_alt,
                  color: rentWheelsBrandDark900,
                  size: Sizes().height(context, 0.03),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
