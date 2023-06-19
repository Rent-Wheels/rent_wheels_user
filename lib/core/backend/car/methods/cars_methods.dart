import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels/core/models/cars/cars_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/backend/car/endpoints/cars_endpoints.dart';

class RentWheelsCarsMethods extends RentWheelsCarsEndpoint {
  @override
  Stream<List<Car>> getAllAvailableCars() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      final response = await get(Uri.parse('${global.baseURL}/cars/available'),
          headers: global.headers);
      if (response.statusCode == 200) {
        List results = jsonDecode(response.body);
        yield List<Car>.from(results.map((car) => Car.fromJSON(car)));
      } else {
        throw Exception();
      }
    }
  }
}
