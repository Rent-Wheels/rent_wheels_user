import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_wheels/core/image/provider/image_provider.dart';
import 'package:rent_wheels/core/search/presentation/provider/search_provider.dart';
import 'package:rent_wheels/core/search/presentation/widgets/custom_search_bottom_sheet.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/popups/success_popup.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/src/files/presentation/bloc/files_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:string_validator/string_validator.dart';

import 'package:rent_wheels/core/util/date_util.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/popups/date_picker_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/textfields/tappable_textfield.dart';
import 'package:rent_wheels/core/widgets/bottomSheets/media_bottom_sheet.dart';
import 'package:rent_wheels/core/widgets/textfields/generic_textfield_widget.dart';
import 'package:rent_wheels/core/widgets/buttons/adaptive_back_button_widget.dart';
import 'package:rent_wheels/core/widgets/profilePicture/profile_picture_widget.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  File? _avatar;

  late GlobalProvider _globalProvider;
  late ImageSelectionProvider _imageProvider;

  bool _isDobValid = false;
  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isAvatarValid = false;
  bool _isResidenceValid = false;
  bool _isPhoneNumberValid = false;

  TextEditingController dob = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController residence = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  final _filesBloc = sl<FilesBloc>();
  final _authBloc = sl<AuthenticationBloc>();

  bool isActive() {
    return _isAvatarValid ||
        _isDobValid ||
        _isNameValid ||
        _isEmailValid ||
        _isResidenceValid ||
        _isPhoneNumberValid;
  }

  openImage({required ImageSource source}) async {
    _avatar = await _imageProvider.openImage(source: source);

    if (_avatar == null) return;

    setState(() {
      _isAvatarValid = true;
    });
  }

  placeOnTap(Prediction p) async {
    residence.text = await context.read<SearchProvider>().setLocation(p);
    _isResidenceValid = true;
    setState(() {});

    if (!mounted) return;
    context.pop();
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

  fillDetails() {
    final global = context.read<GlobalProvider>();
    name.text = global.userDetails!.name!;
    email.text = global.userDetails!.email!;
    phoneNumber.text = global.userDetails!.phoneNumber!;
    residence.text = global.userDetails!.placeOfResidence!;
    dob.text = formatDate(DateTime.parse(global.userDetails!.dob!));
  }

  initUpdate() {
    buildLoadingIndicator(context, 'Updating Account Details');

    if (_avatar != null) {
      uploadProfileImage();
    } else {
      updateUser();
    }
  }

  updateUser({String? profilePicture}) {
    final params = {
      'body': {
        'name': name.text,
        'email': email.text,
        'phoneNumber': phoneNumber.text,
        'placeOfResidence': residence.text,
        'userId': _globalProvider.user!.uid,
        'dob': parseDate(dob.text).toIso8601String(),
        'profilePicture':
            profilePicture ?? _globalProvider.userDetails!.profilePicture
      }
    };
    _authBloc.add(CreateOrUpdateUserEvent(params: params));
  }

  uploadProfileImage() {
    final params = {
      'fileUrl': _avatar!.path,
    };
    _filesBloc.add(
      GetFileUrlEvent(
        params: params,
      ),
    );
  }

  updateEmail() {
    final params = {
      'user': _globalProvider.user,
      'emal': email.text,
    };

    _authBloc.add(UpdateUserEvent(params: params));
  }

  @override
  void initState() {
    fillDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();
    _imageProvider = context.watch<ImageSelectionProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: AdaptiveBackButton(
          onPressed: () => context.pop(),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener(
            bloc: _filesBloc,
            listener: (context, state) {
              if (state is GenericFilesError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is GetFileUrlLoaded) {
                updateUser(profilePicture: state.fileUrl);
              }
            },
          ),
          BlocListener(
            bloc: _authBloc,
            listener: (context, state) {
              if (state is GenericBackendAuthError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is GenericFirebaseAuthError) {
                context.pop();
                showErrorPopUp(state.errorMessage, context);
              }

              if (state is CreateUpdateUserLoaded) {
                _globalProvider.updateUserDetails(state.user);

                if (_isEmailValid) {
                  updateEmail();
                } else {
                  context.pop();
                  showSuccessPopUp('Profile Updated', context);
                }
              }

              if (state is UpdateUserLoaded) {
                _globalProvider.reloadCurrentUser();
                setState(() {
                  _isAvatarValid = false;
                  _isDobValid = false;
                  _isNameValid = false;
                  _isEmailValid = false;
                  _isResidenceValid = false;
                  _isPhoneNumberValid = false;
                });

                context.pop();
                showSuccessPopUp('Profile Updated', context);
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.all(Sizes().height(context, 0.02)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Account Profile",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.03),
                ProfilePicture(
                  imageFile: _avatar,
                  onTap: bottomSheet,
                  imgUrl: _globalProvider.userDetails?.profilePicture,
                ),
                Space().height(context, 0.02),
                GenericTextField(
                  hint: 'Full Name',
                  controller: name,
                  maxLines: 1,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    setState(() {
                      _isNameValid = value.length >= 4 &&
                          value.trimRight() !=
                              _globalProvider.userDetails!.name;
                    });
                  },
                ),
                Space().height(context, 0.02),
                GenericTextField(
                  hint: 'Email',
                  controller: email,
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  enableSuggestions: false,
                  onChanged: (value) {
                    setState(() {
                      _isEmailValid = isEmail(value) &&
                          value.trimRight() !=
                              _globalProvider.userDetails!.email;
                    });
                  },
                ),
                Space().height(context, 0.02),
                GenericTextField(
                  hint: 'Phone Number',
                  controller: phoneNumber,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  onChanged: (value) {
                    setState(() {
                      _isPhoneNumberValid = value.length == 10 &&
                          value.trimRight() !=
                              _globalProvider.userDetails!.phoneNumber;
                    });
                  },
                ),
                Space().height(context, 0.02),
                buildTappableTextField(
                  hint: 'Residence',
                  context: context,
                  controller: residence,
                  onTap: () => buildCustomSearchBottomSheet(
                    context: context,
                    placeOnTap: placeOnTap,
                  ),
                ),
                Space().height(context, 0.02),
                buildTappableTextField(
                  hint: 'Date of Birth',
                  context: context,
                  controller: dob,
                  onTap: () => presentDatePicker(
                      context: context,
                      initialDate: parseDate(dob.text),
                      onDateTimeChanged: (pickedDate) {
                        setState(() {
                          dob.text = formatDate(pickedDate);
                          _isDobValid = true;
                        });
                      },
                      onPressed: () {
                        if (dob.text.isEmpty) {
                          setState(() {
                            formatDate(DateTime(2005));
                          });
                        }
                        context.pop();
                      }),
                ),
                Space().height(context, 0.05),
                GenericButton(
                  width: Sizes().width(context, 0.85),
                  isActive: isActive(),
                  buttonName: 'Update Account',
                  onPressed: initUpdate,
                ),
                Space().height(context, 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
