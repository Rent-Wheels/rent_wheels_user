import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:rent_wheels/core/urls/endpoints.dart';
import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/firebase_options.dart';
import 'package:rent_wheels/src/authentication/data/datasources/backend/remoteds.dart';
import 'package:rent_wheels/src/authentication/data/datasources/firebase/remoteds.dart';
import 'package:rent_wheels/src/user/data/model/user_info_model.dart';

class AuthenticationRemoteDatasourceImpl
    implements
        FirebaseAuthenticationRemoteDatasource,
        BackendAuthenticationRemoteDatasource {
  final Urls url;
  final http.Client client;
  final FirebaseAuth firebase;

  AuthenticationRemoteDatasourceImpl({
    required this.client,
    required this.url,
    required this.firebase,
  });

  @override
  Future<BackendUserInfoModel> createOrUpdateUser(
      Map<String, dynamic> params) async {
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

    return BackendUserInfoModel.fromJSON(decodedResponse);
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebase.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> deleteUserFromBackend(Map<String, dynamic> params) async {
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

  @override
  Future<void> deleteUserFromFirebase({required User user}) async {
    return await user.delete();
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<void> logout() async {
    return await firebase.signOut();
  }

  @override
  Future<UserCredential> reauthenticateUser({
    required User user,
    required String email,
    required String password,
  }) async {
    return await user.reauthenticateWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
  }

  @override
  Future<void> resetPassword({required String email}) async {
    return await firebase.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await firebase.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> updateUserDetails({
    required User user,
    String? email,
    String? password,
  }) async {
    if (email != null) {
      await user.updateEmail(email);
    }
    if (password != null) {
      await user.updatePassword(password);
    }
  }

  @override
  Future<void> verifyEmail({required User user}) async {
    return await user.sendEmailVerification();
  }
}
