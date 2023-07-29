import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/backend/reservations/endpoints/reservations_endpoints.dart';

class RentWheelsReservationsMethods extends RentWheelsReservationsEndpoint {
  @override
  Stream<List<ReservationModel>> getAllReservations() {
    // TODO: implement getAllReservations
    throw UnimplementedError();
  }
  // @override
  // Stream<List<Car>> getAllAvailableCars() async* {
  //   yield* Stream.periodic(const Duration(milliseconds: 30), (_) {
  //     return get(Uri.parse('${global.baseURL}/cars/available'),
  //             headers: global.headers)
  //         .then((response) {
  //       if (response.statusCode == 200) {
  //         List results = jsonDecode(response.body);
  //         return List<Car>.from(results.map((car) => Car.fromJSON(car)));
  //       } else {
  //         throw Exception(response.body);
  //       }
  //     });
  //   }).asyncMap((event) async => await event);
  // }

  @override
  Future<ReservationModel> makeReservation({
    required ReservationModel reservationDetails,
  }) async {
    global.headers.addEntries({
      'content-type': 'application/json',
      'accept': 'application/json'
    }.entries);

    try {
      final body = {
        'car': reservationDetails.car,
        'price': reservationDetails.price,
        'renter': reservationDetails.renter,
        'destination': reservationDetails.destination,
        'startDate': reservationDetails.startDate!.toIso8601String(),
        'returnDate': reservationDetails.returnDate!.toIso8601String(),
        'customer': {
          'id': reservationDetails.customer!.id,
          'name': reservationDetails.customer!.name,
        },
      };
      final response = await post(
        Uri.parse('${global.baseURL}/reservations/'),
        headers: global.headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        return ReservationModel.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }

  // @override
  // Stream<List<Car>> getAvailableCarsNearYou() async* {
  //   yield* Stream.periodic(const Duration(milliseconds: 30), (_) {
  //     return get(
  //             Uri.parse(
  //                 '${global.baseURL}/cars/available?location=${getRegion()}'),
  //             headers: global.headers)
  //         .then((response) {
  //       if (response.statusCode == 200) {
  //         List results = jsonDecode(response.body);
  //         return List<Car>.from(results.map((car) => Car.fromJSON(car)));
  //       } else {
  //         throw Exception(response.body);
  //       }
  //     });
  //   }).asyncMap((event) async => await event);
  // }
}
