import 'dart:convert';

import 'package:http/http.dart';

import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/models/reservations/reservations_model.dart';
import 'package:rent_wheels/core/backend/reservations/endpoints/reservations_endpoints.dart';

class RentWheelsReservationsMethods extends RentWheelsReservationsEndpoint {
  @override
  Future<List<ReservationModel>> getAllReservations() async {
    final response = await get(
        Uri.parse(
            '${global.baseURL}/reservations/?userId=${global.userDetails!.id}/'),
        headers: global.headers);
    if (response.statusCode == 200) {
      List results = jsonDecode(response.body);
      return List<ReservationModel>.from(
        results.map(
          (result) => ReservationModel.fromJSON(result),
        ),
      );
    } else {
      throw Exception(response.body);
    }
  }

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
        'car': reservationDetails.car!.carId,
        'price': reservationDetails.price,
        'renter': reservationDetails.renter!.id,
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

  @override
  Future<ReservationModel> cancelReservation({
    required String reservationId,
  }) async {
    global.headers.addEntries({
      'content-type': 'application/json',
      'accept': 'application/json'
    }.entries);

    try {
      final body = {'status': 'Cancelled'};
      final response = await patch(
        Uri.parse('${global.baseURL}/reservations/$reservationId/status'),
        headers: global.headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return ReservationModel.fromJSON(jsonDecode(response.body));
      }
      throw Exception(response.body);
    } catch (e) {
      throw Exception(e);
    }
  }
}
