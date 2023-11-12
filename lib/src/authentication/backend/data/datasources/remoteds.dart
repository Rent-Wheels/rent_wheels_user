import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/src/user/data/model/user_info_model.dart';

abstract class BackendAuthenticationRemoteDatasource {
  /// create or update user

  Future<UserInfoModel> createOrUpdateUser(Map<String, dynamic> params);

  /// delete user

  Future<void> deleteUser(Map<String, dynamic> params);
}

class BackendAuthenticationRemoteDatasourceImpl
    implements BackendAuthenticationRemoteDatasource {
  final http.Client client;
  final Urls url;

  BackendAuthenticationRemoteDatasourceImpl(
      {required this.client, required this.url});

  @override
  Future<UserInfoModel> createOrUpdateUser(Map<String, dynamic> params) async {
    final isCreate = params['type'] == 'create';
    Uri uri;
    http.Response response;

    if (isCreate) {
      uri = url.returnUri(endpoint: Endpoints.registerUser);
      response = await client.post(
        uri,
        body: params['body'],
      );
    } else {
      uri = url.returnUri(
        endpoint: Endpoints.updateGetOrDeleteUser,
        urlParameters: params['urlParameters'],
      );

      Map<String, String> headers = url.headers;
      headers.addAll({'Authorization': params['token']});

      response = await client.patch(
        uri,
        body: params['body'],
      );
    }

    final decodedResponse = json.decode(response.body);

    if (response.statusCode != 201 || response.statusCode != 200) {
      throw Exception(decodedResponse);
    }

    return UserInfoModel.fromJSON(decodedResponse);
  }

  @override
  Future<void> deleteUser(Map<String, dynamic> params) async {
    final uri = url.returnUri(
      endpoint: Endpoints.updateGetOrDeleteUser,
      urlParameters: params['urlParameters'],
    );

    Map<String, String> headers = url.headers;
    headers.addAll({'Authorization': params['token']});

    final response = await client.delete(uri);

    if (response.statusCode == 200) {
      return;
    }

    throw Exception(json.decode(response.body));
  }
}
