import 'package:flutter/material.dart';

void main() {
  runApp(const RentWheelsApp());
}

class RentWheelsApp extends StatelessWidget {
  const RentWheelsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Wheels',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
