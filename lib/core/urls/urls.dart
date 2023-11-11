import 'package:rent_wheels/core/urls/endpoints.dart';

class Urls {
  final UrlParser urlParser = UrlParser();
  final Map<String, String> headers = {'Content-Type': 'application/json'};
  final String baseURL = 'https://rent-wheels.braalex.me';

  returnUri({
    required Endpoints endpoint,
    Map<String, dynamic>? urlParameters,
  }) {
    String lastRoute = endpoint.value;

    String parsedRoute = urlParser.urlPasser(urlParameters, lastRoute);

    return Uri.https(baseURL, parsedRoute);
  }
}

class UrlParser {
  String urlPasser(Map<String, dynamic>? urlParameters, String lastRoute) {
    // check for any word that starts with :
    final RegExp placeholderRegex = RegExp(r':\w+');

    // Find all placeholders in the URL pattern
    Iterable<Match> matches = placeholderRegex.allMatches(lastRoute);

    if (urlParameters == null || matches.isEmpty) {
      return lastRoute;
    }

    for (Match match in matches) {
      String? key = match.group(0);

      if (key != null) {
        // remove : from key
        String trimmedKey = key.substring(1);
        if (urlParameters.containsKey(trimmedKey)) {
          // replace key with value in map
          lastRoute =
              lastRoute.replaceAll(key, urlParameters[trimmedKey].toString());
        }
      }
    }
    return lastRoute;
  }
}
