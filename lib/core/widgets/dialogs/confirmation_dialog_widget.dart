import 'package:flutter/material.dart';
import 'package:rent_wheels/core/widgets/popups/confirmation_popup_widget.dart';

buildConfirmationDialog({
  String? message,
  required BuildContext context,
  required String label,
  required void Function()? onCancel,
  required void Function()? onAccept,
}) =>
    showDialog(
      context: context,
      builder: (context) => buildConfirmationPopup(
        context: context,
        label: label,
        onCancel: onCancel,
        onAccept: onAccept,
      ),
    );
