import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/assets/svgs/svg_constants.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/user/presentation/widgets/profile_options_widget.dart';

import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/src/user/presentation/widgets/reauthenticate_user_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late GlobalProvider _globalProvider;

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();

    final Map<String, void Function()> sectionOnTap = {
      'accountProfile': () => context.pushNamed('accountProfile'),
      'changePassword': () => context.pushNamed('changePassword'),
      'notifications': () => context.pushNamed('notifications'),
      'deleteAccount': () => buildReauthenticateUserDialog(context),
    };
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes().width(context, 0.04),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Space().height(context, 0.04),
                Text(
                  "Profile",
                  style: theme.textTheme.titleSmall!.copyWith(
                    color: rentWheelsInformationDark900,
                  ),
                ),
                Space().height(context, 0.03),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: Sizes().height(context, 0.081),
                      width: Sizes().width(context, 0.162),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            _globalProvider.userDetails!.profilePicture!,
                          ),
                        ),
                        border: Border.all(color: rentWheelsNeutralLight200),
                        color: rentWheelsNeutralLight0,
                        borderRadius: BorderRadius.circular(
                          Sizes().height(context, 0.015),
                        ),
                      ),
                    ),
                    Space().width(context, 0.03),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _globalProvider.userDetails!.name!,
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: rentWheelsNeutralDark900,
                          ),
                        ),
                        Space().height(context, 0.005),
                        Text(
                          _globalProvider.userDetails!.email!,
                          style: theme.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: rentWheelsNeutralDark900,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Space().height(context, 0.03),
                ...ProfileSections.values.map(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileOptions(
                        svg: e.icon,
                        section: e.label,
                        onTap: sectionOnTap[e.name],
                        style: e.name != 'deleteAccount'
                            ? null
                            : theme.textTheme.headlineMedium!.copyWith(
                                color: rentWheelsErrorDark700,
                              ),
                        color: e.name != 'deleteAccount'
                            ? null
                            : rentWheelsErrorDark700,
                      ),
                      if (e.name != 'deleteAccount') const Divider(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: Sizes().height(context, 0.1),
        color: rentWheelsNeutralLight0,
        child: GenericButton(
          width: Sizes().width(context, 0.85),
          isActive: true,
          buttonName: 'Logout',
          onPressed: () => buildConfirmationDialog(
            label: 'Logout',
            context: context,
            buttonName: 'Logout',
            message: 'Are you sure you want to log out?',
            onAccept: () async {
              // context.pop();
              // buildLoadingIndicator(context, 'Logging Out');
              // try {
              //   await AuthService.firebase().logout();
              //   if (!mounted) return;
              //   context.pop();
              //   Navigator.pushAndRemoveUntil(
              //     context,
              //     CupertinoPageRoute(
              //       builder: (context) => const Login(),
              //     ),
              //     (route) => false,
              //   );
              // } catch (e) {
              //   if (!mounted) return;
              //   context.pop();
              //   showErrorPopUp('Error logging out', context);
              // }
            },
          ),
        ),
      ),
    );
  }
}

enum ProfileSections {
  accountProfile(icon: accountProfileSVG, label: 'Account Profile'),
  changePassword(icon: changePasswordSVG, label: 'Change Password'),
  notifications(icon: notificationsSVG, label: 'Notifications'),
  deleteAccount(icon: trashSVG, label: 'Delete Account');

  final String icon, label;

  const ProfileSections({required this.icon, required this.label});
}
