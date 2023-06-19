import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'package:rent_wheels/secrets.dart' as secret;

const placesKey = secret.mapsKey;

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  TextEditingController location = TextEditingController();
  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: placesKey,
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "gh")],
      types: [],
      strictbounds: false,
    );
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: placesKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(p!.placeId!);

    setState(() {
      location.text =
          '${detail.result.name}, ${detail.result.formattedAddress}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _handlePressButton,
          child: TextField(
            controller: location,
            enabled: false,
            decoration: const InputDecoration(
              hintText: 'Location',
            ),
          ),
        ),
      ),
    );
  }
}
