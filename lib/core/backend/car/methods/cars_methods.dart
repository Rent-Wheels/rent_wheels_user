import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/car/endpoints/cars_endpoints.dart';

class RentWheelsCarsMethods extends RentWheelsCarsEndpoint {
  String getRegion() {
    List<String> splitLocation =
        global.userDetails!.placeOfResidence.split(', ');
    return '${splitLocation[splitLocation.length - 2]}, ${splitLocation[splitLocation.length - 1]}';
  }

  @override
  Stream<List<Car>> getAllAvailableCars() async* {
    yield* Stream.periodic(const Duration(milliseconds: 30), (_) {
      return get(Uri.parse('${global.baseURL}/cars/available'),
              headers: global.headers)
          .then((response) {
        if (response.statusCode == 200) {
          List results = jsonDecode(response.body);
          return List<Car>.from(results.map((car) => Car.fromJSON(car)));
        } else {
          throw Exception(response.body);
        }
      });
    }).asyncMap((event) async => await event);
  }

  @override
  Stream<List<Car>> getAvailableCarsNearYou() async* {
    yield* Stream.periodic(const Duration(milliseconds: 30), (_) {
      return get(
              Uri.parse(
                  '${global.baseURL}/cars/available?location=${getRegion()}'),
              headers: global.headers)
          .then((response) {
        if (response.statusCode == 200) {
          List results = jsonDecode(response.body);
          return List<Car>.from(results.map((car) => Car.fromJSON(car)));
        } else {
          throw Exception(response.body);
        }
      });
    }).asyncMap((event) async => await event);
  }
}
