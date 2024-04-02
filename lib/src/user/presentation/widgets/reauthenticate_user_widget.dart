import 'package:flutter/material.dart';
import 'package:rent_wheels/src/user/presentation/widgets/reauthenticate_user_dialog.dart';

buildReauthenticateUserDialog(BuildContext context) => showDialog(
      context: context,
      builder: (_) => const ReauthenticateUserDialog(),
    );
