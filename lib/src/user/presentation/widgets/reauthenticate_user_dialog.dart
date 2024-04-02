import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/src/files/presentation/bloc/files_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

class ReauthenticateUserDialog extends StatefulWidget {
  const ReauthenticateUserDialog({
    super.key,
  });

  @override
  State<ReauthenticateUserDialog> createState() =>
      _ReauthenticateUserDialogState();
}

class _ReauthenticateUserDialogState extends State<ReauthenticateUserDialog> {
  bool isPasswordValid = false;
  bool isPasswordVisible = false;
  TextEditingController password = TextEditingController();

  late GlobalProvider _globalProvider;
  final _authBloc = sl<AuthenticationBloc>();
  final _fileBloc = sl<FilesBloc>();

  reauthenticateUser() {
    buildLoadingIndicator(context, '');

    final params = {
      'password': password.text,
      'user': _globalProvider.user,
      'email': _globalProvider.userDetails?.email,
    };

    _authBloc.add(ReauthenticateUserEvent(params: params));
  }

  deleteUserDirectory() {
    final params = {
      'directoryPath': 'users/${_globalProvider.user!.uid}',
    };

    _fileBloc.add(DeleteDirectoryEvent(params: params));
  }

  deleteFirebaseUser() {
    final params = {
      'user': _globalProvider.user,
    };

    _authBloc.add(DeleteUserFromFirebaseEvent(params: params));
  }

  deleteBackendUser() {
    final params = {
      'urlParameters': {
        'userId': _globalProvider.user?.uid,
      },
      'headers': _globalProvider.headers,
    };

    _authBloc.add(DeleteUserFromBackendEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.read<GlobalProvider>();

    return Dialog(
      child: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _authBloc,
            listener: (context, state) {
              if (state is GenericFirebaseAuthError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is GenericBackendAuthError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is DeleteUserFromBackendLoaded) {
                context.pop();
                context.goNamed('login');
              }

              if (state is DeleteUserFromFirebaseLoaded) {
                deleteBackendUser();
              }

              if (state is ReauthenticateUserLoaded) {
                context.pop();
                context.pop();
                buildConfirmationDialog(
                  context: context,
                  label: 'Delete Account',
                  buttonName: 'Delete Account',
                  onAccept: deleteUserDirectory,
                  message:
                      'Are you sure you want to delete your account? This action is irreversible!',
                );
              }
            },
          ),
          BlocListener(
            bloc: _fileBloc,
            listener: (context, state) {
              if (state is GenericFilesError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is DeleteDirectoryLoaded) {
                deleteFirebaseUser();
              }
            },
          ),
        ],
        child: Container(
          alignment: Alignment.center,
          height: Sizes().height(context, 0.28),
          padding: EdgeInsets.symmetric(
            vertical: Sizes().height(context, 0.01),
            horizontal: Sizes().width(context, 0.04),
          ),
          decoration: BoxDecoration(
            color: rentWheelsNeutralLight0,
            borderRadius: BorderRadius.circular(
              Sizes().height(context, 0.015),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please enter your password to continue',
                style: theme.textTheme.headlineMedium!.copyWith(
                  color: rentWheelsNeutralDark900,
                ),
              ),
              Space().height(context, 0.02),
              GenericTextField(
                maxLines: 1,
                hint: 'Password',
                onChanged: (value) {
                  setState(() {
                    isPasswordValid = value.length > 5;
                  });
                },
                isPassword: true,
                controller: password,
                enableSuggestions: false,
                isPasswordVisible: isPasswordVisible,
                iconOnTap: () => setState(() {
                  isPasswordVisible = !isPasswordVisible;
                }),
              ),
              Space().height(context, 0.02),
              GenericButton(
                width: Sizes().width(context, 0.9),
                buttonName: 'Continue',
                isActive: isPasswordValid,
                onPressed: reauthenticateUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
