import 'package:flutter/material.dart';
import 'package:rent_wheels/core/models/user/user_model.dart';

class RenterDetails extends StatelessWidget {
  final BackendUser renter;
  const RenterDetails({super.key, required this.renter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(renter.name),
    ));
  }
}
