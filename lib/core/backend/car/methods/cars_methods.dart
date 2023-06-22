import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/car/endpoints/cars_endpoints.dart';

class RentWheelsCarsMethods extends RentWheelsCarsEndpoint {
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
          throw Exception();
        }
      });
    }).asyncMap((event) async => await event);
  }
}
