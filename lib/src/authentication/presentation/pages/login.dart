import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/widgets/buttons/text_button_widget.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/user/presentation/bloc/user_bloc.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late GlobalProvider _globalProvider;

  bool _showPassword = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  final _userBloc = sl<UserBloc>();
  final _authBloc = sl<AuthenticationBloc>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isActive() {
    return _isEmailValid && _isPasswordValid;
  }

  signInWithEmailAndPassword() {
    buildLoadingIndicator(context, 'Logging In');
    final params = {
      'email': _email.text,
      'password': _password.text,
    };

    _authBloc.add(SignInWithEmailAndPasswordEvent(params: params));
  }

  getUserDetails() {
    final params = {
      'urlParameters': {
        'userId': _globalProvider.user?.uid,
      },
      'headers': _globalProvider.headers
    };

    _userBloc.add(GetUserDetailsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _authBloc,
            listener: (context, state) {
              if (state is GenericFirebaseAuthError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is SignInWithEmailAndPasswordLoaded) {
                _globalProvider.updateCurrentUser(state.user.user);
                _globalProvider.updateHeaders(state.user.user);

                if (!(state.user.user?.emailVerified ?? false)) {
                  context.goNamed('verifyEmail');
                } else {
                  getUserDetails();
                }
              }
            },
          ),
          BlocListener(
            bloc: _userBloc,
            listener: (context, state) {
              if (state is GenericUserError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is GetUserDetailsLoaded) {
                _globalProvider.updateUserDetails(state.user);
                context.pop();
                context.goNamed('home');
              }
            },
          ),
        ],
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.all(Sizes().height(context, 0.02)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to Rent Wheels',
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: rentWheelsInformationDark900,
                    ),
                  ),
                  Space().height(context, 0.01),
                  Text(
                    'Enter your account details to continue.',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: rentWheelsNeutral,
                    ),
                  ),
                  Space().height(context, 0.03),
                  GenericTextField(
                    maxLines: 1,
                    controller: _email,
                    hint: 'Email Address',
                    enableSuggestions: false,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    onChanged: (value) {
                      setState(() {
                        _isEmailValid = isEmail(value);
                      });
                    },
                  ),
                  Space().height(context, 0.02),
                  GenericTextField(
                    maxLines: 1,
                    hint: 'Password',
                    isPassword: true,
                    controller: _password,
                    textInput: TextInputAction.done,
                    isPasswordVisible: _showPassword,
                    textCapitalization: TextCapitalization.none,
                    iconOnTap: () => setState(() {
                      _showPassword = !_showPassword;
                    }),
                    onChanged: (value) {
                      setState(() {
                        _isPasswordValid = isAscii(value) && value.length > 5;
                      });
                    },
                  ),
                  Space().height(context, 0.05),
                  GenericButton(
                    buttonName: 'Login',
                    isActive: isActive(),
                    width: Sizes().width(context, 0.85),
                    onPressed: signInWithEmailAndPassword,
                  ),
                  Space().height(context, 0.02),
                  SizedBox(
                    width: Sizes().width(context, 0.85),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButtonWidget(
                          width: null,
                          isActive: true,
                          onPressed: () => context.pushNamed('forgotPassword'),
                          buttonName: 'Forgot Password?',
                          textStyle: theme.textTheme.bodyMedium!.copyWith(
                            color: rentWheelsNeutral,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: Sizes().height(context, 0.1),
                    color: rentWheelsNeutralLight0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: rentWheelsNeutral,
                          ),
                        ),
                        TextButtonWidget(
                          width: null,
                          isActive: true,
                          onPressed: () => context.goNamed('signUp'),
                          buttonName: 'Register',
                          textStyle: theme.textTheme.headlineSmall!.copyWith(
                            color: rentWheelsInformationDark900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
