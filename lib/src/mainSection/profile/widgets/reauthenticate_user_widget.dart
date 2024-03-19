import 'package:flutter/material.dart';
import 'package:rent_wheels/src/mainSection/profile/widgets/reauthenticate_user_dialog.dart';

buildReauthenticateUserDialog({
  required BuildContext context,
  required void Function() onSubmit,
  required TextEditingController controller,
}) =>
    showDialog(
      context: context,
      builder: (context) => ReauthenticateUserDialog(
        onSubmit: onSubmit,
        controller: controller,
      ),
    );
