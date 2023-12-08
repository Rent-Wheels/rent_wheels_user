import 'dart:convert';

import 'package:http/http.dart';
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/src/renter/data/models/renter_info_model.dart';

abstract class RenterRemoteDatasource {
  Future<RenterInfoModel> getRenterDetails(Map<String, dynamic> params);
}

class RenterRemoteDatasourceImpl implements RenterRemoteDatasource {
  final Urls urls;
  final Client client;

  RenterRemoteDatasourceImpl({
    required this.urls,
    required this.client,
  });

  @override
  Future<RenterInfoModel> getRenterDetails(Map<String, dynamic> params) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.getRenter,
      urlParameters: {
        'renterId': params['renterId'],
      },
    );

    final headers = urls.headers;
    headers.addAll(<String, String>{'Authorization': params['token']});

    final response = await client.get(uri, headers: headers);

    if (response.statusCode != 200) throw Exception(response.body);
    return RenterInfoModel.fromJSON(jsonDecode(response.body));
  }
}
