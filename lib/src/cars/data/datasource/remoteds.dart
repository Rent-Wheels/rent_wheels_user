import 'dart:convert';

import 'package:http/http.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/src/cars/data/models/cars_model.dart';

abstract class CarsRemoteDatasource {
  ///get all available cars
  Future<List<CarsModel>> getAllAvailableCars(
    Map<String, dynamic> params,
  );
}

class CarsRemoteDatasourceImpl implements CarsRemoteDatasource {
  final Urls urls;
  final Client client;

  CarsRemoteDatasourceImpl({required this.urls, required this.client});
  @override
  Future<List<CarsModel>> getAllAvailableCars(
      Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getAvailableCars,
      queryParameters: params['queryParameters'],
    );

    final response = await client.get(uri, headers: urls.headers);

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode != 200) throw Exception(decodedResponse);

    return decodedResponse.map<CarsModel>((car) => CarsModel.fromJson(car));
  }
}
