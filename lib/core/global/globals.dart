import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/models/user/user_model.dart';

User? user;
String accessToken = '';
Map<String, String> headers = {};
String baseURL = 'http://10.0.2.2:3000';
// String baseURL = 'https://rent-wheels.braalex.me';
BackendUser? userDetails;

setGlobals({User? currentUser, BackendUser? fetchedUserDetails}) async {
  if (currentUser != null) {
    accessToken = await currentUser.getIdToken();
    user = currentUser;
    headers = {'Authorization': 'Bearer $accessToken'};
  }
  if (fetchedUserDetails != null) {
    userDetails = fetchedUserDetails;
  }
}
