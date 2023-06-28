import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/models/user/user_model.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/auth/backend/backend_auth_provider.dart';

class BackendAuthService implements BackendAuthProvider {
  @override
  Future<BackendUser> createUser({
    required String avatar,
    required User user,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  }) async {
    try {
      var request =
          MultipartRequest('POST', Uri.parse('${global.baseURL}/users/'));

      final ext = avatar.split('.').last;
      request.fields['userId'] = user.uid;
      request.fields['name'] = name;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['email'] = email;
      request.fields['dob'] = dob.toIso8601String();
      request.fields['placeOfResidence'] = residence;
      request.files.add(
        MultipartFile(
          'avatar',
          File(avatar).readAsBytes().asStream(),
          File(avatar).lengthSync(),
          filename: 'avatar-${user.uid}.$ext',
          contentType: MediaType.parse(
            lookupMimeType(avatar) ?? 'image/jpeg',
          ),
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        return BackendUser.fromJSON(jsonDecode(responseBody));
      }
      throw Exception(responseBody);
    } catch (e) {
      await user.delete();
      throw Exception(e);
    }
  }

  @override
  Future<BackendUser> updateUser({
    required String? avatar,
    required String userId,
    required String name,
    required String phoneNumber,
    required String email,
    required DateTime dob,
    required String residence,
  }) async {
    try {
      var request = MultipartRequest(
          'PATCH', Uri.parse('${global.baseURL}/users/${global.user!.uid}'));

      final ext = avatar?.split('.').last;
      request.headers['Authorization'] = 'Bearer ${global.accessToken}';
      request.fields['userId'] = userId;
      request.fields['name'] = name;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['email'] = email;
      request.fields['dob'] = dob.toIso8601String();
      request.fields['placeOfResidence'] = residence;

      if (avatar != null) {
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
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return BackendUser.fromJSON(jsonDecode(responseBody));
      }
      throw Exception(responseBody);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  deleteUser({required String userId}) async {
    final response = await delete(
      Uri.parse('${global.baseURL}/users/$userId'),
      headers: global.headers,
    );

    if (response.statusCode != 200) throw GenericAuthException();
  }
}
