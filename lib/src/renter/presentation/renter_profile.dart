import 'package:flutter/material.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';

class RenterDetails extends StatelessWidget {
  final String renterId;
  const RenterDetails({super.key, required this.renterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: RentWheelsUserMethods().getUserDetails(userId: renterId),
        builder: (context, snapshot) {
          return Text(snapshot.data!.name);
        },
      ),
    );
  }
}
