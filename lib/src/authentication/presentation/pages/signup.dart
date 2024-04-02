import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_wheels/core/search/presentation/provider/search_provider.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/core/image/provider/image_provider.dart';
import 'package:rent_wheels/src/files/presentation/bloc/files_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/util/date_util.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/date_picker_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels/core/widgets/profilePicture/profile_picture_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  File? _avatar;

  late GlobalProvider _globalProvider;
  late ImageSelectionProvider _imageProvider;

  bool _isDobValid = false;
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isAvatarValid = false;
  bool _isPasswordValid = false;
  bool _isResidenceValid = false;
  bool _isPhoneNumberValid = false;

  final _fileBloc = sl<FilesBloc>();
  final _authBloc = sl<AuthenticationBloc>();
  final TextEditingController _dob = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _residence = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();

  bool isActive() {
    return _isAvatarValid &&
        _isDobValid &&
        _isNameValid &&
        _isEmailValid &&
        _isPasswordValid &&
        _isResidenceValid &&
        _isPhoneNumberValid;
  }

  openImage({required ImageSource source}) async {
    _avatar = await _imageProvider.openImage(source: source);

    if (_avatar == null) return;

    setState(() {
      _isAvatarValid = true;
    });
  }

  bottomSheet() {
    return mediaBottomSheet(
      context: context,
      cameraOnTap: () {
        openImage(source: ImageSource.camera);
        context.pop();
      },
      galleryOnTap: () {
        openImage(source: ImageSource.gallery);
        context.pop();
      },
    );
  }

  placeOnTap(Prediction p) async {
    _residence.text = await context.read<SearchProvider>().setLocation(p);
    _isResidenceValid = true;
    setState(() {});

    if (!mounted) return;
    context.pop();
  }

  createFirebaseUser() {
    buildLoadingIndicator(context, 'Creating Account');
    final params = {
      'email': _email.text,
      'password': _password.text,
    };

    _authBloc.add(CreateUserWithEmailAndPasswordEvent(params: params));
  }

  saveProfileImage() {
    final ext = _avatar!.path.split('.').last;
    final params = {
      'file': _avatar!,
      'filePath':
          'users/${_globalProvider.user!.uid}/avatar/${_globalProvider.user!.uid}.$ext',
    };

    _fileBloc.add(GetFileUrlEvent(params: params));
  }

  sendVerificationEmail() {
    _authBloc.add(VerifyEmailEvent(params: {'user': _globalProvider.user}));
  }

  createBackendUser(String imagePath) {
    final params = {
      'type': 'create',
      'body': {
        'name': _name.text,
        'userId': _globalProvider.user!.uid,
        'email': _email.text,
        'profilePicture': imagePath,
        'phoneNumber': _phoneNumber.text,
        'placeOfResidence': _residence.text,
        'dob': parseDate(_dob.text),
      },
    };

    _authBloc.add(CreateOrUpdateUserEvent(params: params));
  }

  deleteUser() {
    final params = {
      'user': _globalProvider.user,
    };

    _authBloc.add(DeleteUserFromFirebaseEvent(params: params));
  }

  deleteFiles() {
    final ext = _avatar!.path.split('.').last;
    final params = {
      'filePath':
          'users/${_globalProvider.user!.uid}/avatar/${_globalProvider.user!.uid}.$ext',
    };
    _fileBloc.add(DeleteFileEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();
    _imageProvider = context.watch<ImageSelectionProvider>();
    return Scaffold(
      body: SafeArea(
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
                  deleteUser();
                }

                if (state is CreateUserWithEmailAndPasswordLoaded) {
                  _globalProvider.updateCurrentUser(state.user.user);
                  _globalProvider.updateHeaders(state.user.user);
                  saveProfileImage();
                }

                if (state is CreateUpdateUserLoaded) {
                  _globalProvider.updateUserDetails(state.user);
                  sendVerificationEmail();
                }

                if (state is VerifyEmailLoaded) {
                  context.pop();
                  context.goNamed('verifyEmail');
                }

                if (state is DeleteUserFromFirebaseLoaded) {
                  deleteFiles();
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
                if (state is GetFileUrlLoaded) {
                  createBackendUser(state.fileUrl);
                }
              },
            ),
          ],
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: EdgeInsets.all(
                Sizes().height(context, 0.02),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Let's get your account setup",
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: rentWheelsInformationDark900,
                    ),
                  ),
                  Space().height(context, 0.03),
                  ProfilePicture(
                    imageFile: _avatar,
                    onTap: bottomSheet,
                  ),
                  Space().height(context, 0.02),
                  GenericTextField(
                    hint: 'Full Name',
                    controller: _name,
                    maxLines: 1,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (value) => setState(() {
                      _isNameValid = value.length >= 4;
                    }),
                  ),
                  Space().height(context, 0.02),
                  GenericTextField(
                    hint: 'Email',
                    controller: _email,
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    onChanged: (value) => setState(() {
                      _isEmailValid = isEmail(value);
                    }),
                  ),
                  Space().height(context, 0.02),
                  GenericTextField(
                    hint: 'Password',
                    controller: _password,
                    isPassword: true,
                    textCapitalization: TextCapitalization.none,
                    maxLines: 1,
                    onChanged: (value) {
                      final regExp = RegExp(
                          r'(?=^.{8,255}$)((?=.*\d)(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[^A-Za-z0-9])(?=.*[a-z])|(?=.*[^A-Za-z0-9])(?=.*[A-Z])(?=.*[a-z])|(?=.*\d)(?=.*[A-Z])(?=.*[^A-Za-z0-9]))^.*');
                      setState(() {
                        _isPasswordValid = regExp.hasMatch(value);
                      });
                    },
                  ),
                  Space().height(context, 0.005),
                  Text(
                    '8 or more characters\n1 or more capital letters\n1 or more special characters',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: rentWheelsNeutralDark900,
                    ),
                  ),
                  Space().height(context, 0.02),
                  GenericTextField(
                    hint: 'Phone Number',
                    controller: _phoneNumber,
                    maxLines: 1,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) => setState(() {
                      _isPhoneNumberValid = value.length == 10;
                    }),
                  ),
                  Space().height(context, 0.02),
                  GenericTextField(
                    hint: 'Residence',
                    controller: _residence,
                    maxLines: 1,
                    onChanged: (value) => setState(() {
                      _isResidenceValid = value.length > 1;
                    }),
                  ),
                  Space().height(context, 0.02),
                  TappableTextfield(
                    hint: 'Date of Birth',
                    controller: _dob,
                    onTap: () => presentDatePicker(
                        context: context,
                        onDateTimeChanged: (pickedDate) {
                          setState(() {
                            _dob.text = formatDate(pickedDate);
                            _isDobValid = true;
                          });
                        },
                        onPressed: () {
                          if (_dob.text.isEmpty) {
                            setState(() {
                              _dob.text = formatDate(DateTime(2005));
                              _isDobValid = true;
                            });
                          }
                          context.pop();
                        }),
                  ),
                  Space().height(context, 0.05),
                  GenericButton(
                    width: Sizes().width(context, 0.85),
                    isActive: isActive(),
                    buttonName: 'Register',
                    onPressed: createFirebaseUser,
                  ),
                  Space().height(context, 0.01),
                  Container(
                    height: Sizes().height(context, 0.1),
                    color: rentWheelsNeutralLight0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: rentWheelsNeutral,
                          ),
                        ),
                        Space().width(context, 0.01),
                        GestureDetector(
                          onTap: () => context.goNamed('login'),
                          child: Text(
                            "Login",
                            style: theme.textTheme.headlineSmall!.copyWith(
                              color: rentWheelsInformationDark900,
                            ),
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
