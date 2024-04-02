import 'dart:convert';

import 'package:http/http.dart';
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/src/renter/data/models/renter_model.dart';

abstract class RenterRemoteDatasource {
  Future<RenterModel> getRenterDetails(Map<String, dynamic> params);
}

class RenterRemoteDatasourceImpl implements RenterRemoteDatasource {
  final Urls urls;
  final Client client;

  RenterRemoteDatasourceImpl({
    required this.urls,
    required this.client,
  });

  @override
  Future<RenterModel> getRenterDetails(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getRenter,
      urlParameters: params['urlParameters'],
    );

    final response = await client.get(uri, headers: params['headers']);

    if (response.statusCode != 200) throw Exception(response.body);
    return RenterModel.fromJSON(jsonDecode(response.body));
  }
}
