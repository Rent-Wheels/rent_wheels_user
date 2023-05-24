import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/models/auth/auth_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/auth/backend/backend_auth_provider.dart';

class BackendAuthService implements BackendAuthProvider {
  @override
  Future<User> createUser({
    required String avatar,
    required String userId,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  }) async {
    var request = MultipartRequest(
        'POST', Uri.parse('https://rent-wheels.braalex.me/users/'));

    final ext = avatar.split('.').last;
    request.fields['userId'] = userId;
    request.fields['name'] = name;
    request.fields['phoneNumber'] = phoneNumber;
    request.fields['email'] = email;
    request.fields['dob'] = dob.toIso8601String();
    request.fields['residence'] = residence;
    request.files.add(
      MultipartFile(
        'avatar',
        File(avatar).readAsBytes().asStream(),
        File(avatar).lengthSync(),
        filename: 'avatar-$userId.$ext',
        contentType: MediaType.parse(
          lookupMimeType(avatar) ?? 'image/jpeg',
        ),
      ),
    );

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return User.fromJSON(jsonDecode(responseBody));
    } else {
      throw GenericAuthException();
    }
  }

  @override
  deleteUser({required String userId}) async {
    final headers = {'Authorization': 'Bearer ${global.accessToken}'};
    final response = await delete(
      Uri.parse('https://rent-wheels.braalex.me/users/$userId'),
      headers: headers,
    );

    if (response.statusCode != 200) throw GenericAuthException();
  }
}
