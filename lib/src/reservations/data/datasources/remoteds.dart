import 'dart:convert';

import 'package:http/http.dart';
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/src/reservations/data/model/reservation_model.dart';

abstract class ReservationsRemoteDatasource {
  Future<ReservationModel> makeReservation(Map<String, dynamic> params);
  Future<ReservationModel> changeReservationStatus(Map<String, dynamic> params);
  Future<List<ReservationModel>> getAllReservations(
      Map<String, dynamic> params);
}

class ReservationsRemoteDatasourceImpl implements ReservationsRemoteDatasource {
  final Client client;
  final Urls urls;

  ReservationsRemoteDatasourceImpl({
    required this.client,
    required this.urls,
  });

  @override
  Future<ReservationModel> changeReservationStatus(
    Map<String, dynamic> params,
  ) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.changeReservationStatus,
      urlParameters: params['urlParameters'],
    );

    final response = await client.patch(
      uri,
      headers: params['headers'],
      body: jsonEncode(params['body']),
    );

    if (response.statusCode != 200) throw Exception(response.body);

    return ReservationModel.fromJSON(jsonDecode(response.body));
  }

  @override
  Future<List<ReservationModel>> getAllReservations(
    Map<String, dynamic> params,
  ) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getOrCreateReservations,
      queryParameters: params['queryParameters'],
    );

    final response = await client.get(
      uri,
      headers: params['headers'],
    );

    if (response.statusCode != 200) throw Exception(response.body);

    final decodedResponse = jsonDecode(response.body);

    return decodedResponse
        .map<ReservationModel>(
          (result) => ReservationModel.fromJSON(result),
        )
        .toList();
  }

  @override
  Future<ReservationModel> makeReservation(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getOrCreateReservations,
    );

    final response = await client.post(
      uri,
      headers: params['headers'],
      body: jsonEncode(params['body']),
    );

    if (response.statusCode != 201) throw Exception(response.body);

    return ReservationModel.fromJSON(jsonDecode(response.body));
  }
}
