import 'dart:convert';

import 'package:http/http.dart';
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/src/user/data/model/user_info_model.dart';

abstract class UserRemoteDatasource {
  Future<BackendUserInfoModel> getUserDetails(Map<String, dynamic> params);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final Client client;
  final Urls urls;

  UserRemoteDatasourceImpl({
    required this.client,
    required this.urls,
  });

  @override
  Future<BackendUserInfoModel> getUserDetails(
    Map<String, dynamic> params,
  ) async {
    final uri = urls.returnUri(
      endpoint: Endpoints.updateGetOrDeleteUser,
      urlParameters: params['urlParameters'],
    );

    final response = await client.get(
      uri,
      headers: params['headers'],
    );

    if (response.statusCode != 200) throw Exception(response.body);

    return BackendUserInfoModel.fromJSON(jsonDecode(response.body));
  }
}
