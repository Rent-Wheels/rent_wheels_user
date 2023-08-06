import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rent_wheels/core/models/user/user_model.dart';

User? user;
String accessToken = '';
Map<String, String> headers = {};
// String baseURL = 'http://10.0.2.2:3000';
// String baseURL = 'http://localhost:3000';
String baseURL = 'https://rent-wheels.braalex.me';
BackendUser? userDetails;
const shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

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

resetGlobals() {
  user = null;
  accessToken = '';
  headers = {};
  userDetails = null;
}
