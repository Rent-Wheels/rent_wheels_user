import 'package:flutter/material.dart';

buildLocationTextfield({
  required String location,
  required void Function() onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 30,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(),
        ),
      ),
      child: Text(location.isEmpty ? 'Residence' : location),
    ),
  );
}
