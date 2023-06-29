import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/secrets/secrets.dart' as secret;
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold({super.key})
      : super(
          apiKey: secret.mapsKey,
          sessionToken: const Uuid().v4(),
          language: "en",
          components: [Component(Component.country, "gh")],
          types: [],
          strictbounds: false,
        );

  @override
  CustomSearchScaffoldState createState() => CustomSearchScaffoldState();
}

class CustomSearchScaffoldState extends PlacesAutocompleteState {
  Future<String> setLocation(Prediction p) async {
    // get detail (lat/lng)
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: secret.mapsKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    return detail.result.name == detail.result.formattedAddress!.split(',')[0]
        ? detail.result.formattedAddress!
        : '${detail.result.name}, ${detail.result.formattedAddress}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        backgroundColor: rentWheelsNeutralLight0,
        foregroundColor: rentWheelsBrandDark900,
        leading: buildAdaptiveBackButton(
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        title: AppBarPlacesAutoCompleteTextField(
          textStyle: heading6Neutral900,
          textDecoration: const InputDecoration(
            hintText: 'Search',
            hintStyle: heading6Neutral500,
            border: InputBorder.none,
          ),
        ),
      ),
      body: PlacesAutocompleteResult(
        onTap: (p) async {
          final location = await setLocation(p);
          if (!mounted) return;
          Navigator.pop(context, location);
        },
        logo: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
