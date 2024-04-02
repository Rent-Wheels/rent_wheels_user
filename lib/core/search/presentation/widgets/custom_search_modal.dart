import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/secrets/secrets.dart' as secret;

class CustomSearchModal extends PlacesAutocompleteWidget {
  final void Function(Prediction)? placeOnTap;
  CustomSearchModal({
    super.key,
    required this.placeOnTap,
  }) : super(
          apiKey: secret.mapsKey,
          sessionToken: const Uuid().v4(),
          language: "en",
          components: [Component(Component.country, "gh")],
          types: [],
          strictbounds: false,
        );

  @override
  CustomSearchModalState createState() => CustomSearchModalState();
}

class CustomSearchModalState extends State<CustomSearchModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Sizes().height(context, 0.7),
      padding: EdgeInsets.symmetric(
        horizontal: Sizes().width(context, 0.04),
      ),
      decoration: BoxDecoration(
        color: rentWheelsNeutralLight0,
        borderRadius: BorderRadius.circular(
          Sizes().height(context, 0.01),
        ),
      ),
      child: Column(
        children: [
          AppBarPlacesAutoCompleteTextField(
            textStyle: theme.textTheme.headlineSmall!.copyWith(
              color: rentWheelsNeutralDark900,
            ),
            textDecoration: const InputDecoration(
              hintText: 'Search',
            ),
          ),
          Expanded(
            child: PlacesAutocompleteResult(
              onTap: widget.placeOnTap,
              logo: const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
