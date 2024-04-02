import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/popups/confirmation_popup_widget.dart';

buildConfirmationDialog({
  String? message,
  Color? btnColor,
  required String label,
  required String buttonName,
  required BuildContext context,
  required void Function()? onAccept,
}) =>
    showDialog(
      context: context,
      builder: (context) => ConfirmationPopup(
        label: label,
        message: message,
        onAccept: onAccept,
        btnColor: btnColor,
        buttonName: buttonName,
      ),
    );
