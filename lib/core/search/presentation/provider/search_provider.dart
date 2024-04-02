import 'package:flutter/material.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:rent_wheels/core/secrets/secrets.dart' as secret;

class SearchProvider extends ChangeNotifier {
  Future<String> setLocation(Prediction p) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: secret.mapsKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    return detail.result.name == detail.result.formattedAddress!.split(',')[0]
        ? detail.result.formattedAddress!
        : '${detail.result.name}, ${detail.result.formattedAddress}';
  }
}
