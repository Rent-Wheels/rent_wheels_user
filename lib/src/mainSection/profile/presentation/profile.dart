import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/core/auth/auth_exceptions.dart';
import 'package:rent_wheels/core/widgets/theme/theme.dart';
import 'package:rent_wheels/core/widgets/toast/toast_notification_widget.dart';

import 'package:rent_wheels/src/authentication/presentation/pages/login.dart';
import 'package:rent_wheels/src/mainSection/profile/widgets/profile_options_widget.dart';
import 'package:rent_wheels/src/mainSection/profile/presentation/sections/accountProfile/presentation/account_profile.dart';
import 'package:rent_wheels/src/mainSection/profile/presentation/sections/changePassword/presentation/change_password.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';
import 'package:rent_wheels/core/widgets/dialogs/confirmation_dialog_widget.dart';
import 'package:rent_wheels/src/mainSection/profile/widgets/reauthenticate_user_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController password = TextEditingController();
  @override
  void initState() {
    RentWheelsUserMethods().getUserDetails(userId: global.user!.uid).then(
        (userDetails) => global.setGlobals(fetchedUserDetails: userDetails));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                            global.userDetails!.profilePicture,
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
                          global.userDetails!.name,
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: rentWheelsNeutralDark900,
                          ),
                        ),
                        Space().height(context, 0.005),
                        Text(
                          global.userDetails!.email,
                          style: theme.textTheme.headlineSmall!
                              .copyWith(color: rentWheelsNeutralDark900),
                        ),
                      ],
                    )
                  ],
                ),
                Space().height(context, 0.03),
                ProfileOptions(
                  section: 'Account Profile',
                  svg: 'assets/svgs/account_profile.svg',
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const AccountProfile(),
                    ),
                  ),
                ),
                const Divider(),
                ProfileOptions(
                  section: 'Change Password',
                  svg: 'assets/svgs/change_password.svg',
                  onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ChangePassword(),
                    ),
                  ),
                ),
                const Divider(),
                const ProfileOptions(
                  section: 'Notifications',
                  svg: 'assets/svgs/notifications.svg',
                  onTap: buildToastNotification,
                ),
                const Divider(),
                ProfileOptions(
                  section: 'Delete Account',
                  svg: 'assets/svgs/trash.svg',
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: rentWheelsErrorDark700,
                  ),
                  color: rentWheelsErrorDark700,
                  onTap: () => buildReauthenticateUserDialog(
                    context: context,
                    controller: password,
                    onSubmit: () async {
                      try {
                        buildLoadingIndicator(context, '');
                        final reauthenticatedUser =
                            await AuthService.firebase().reauthenticateUser(
                          email: global.userDetails!.email,
                          password: password.text,
                        );

                        await global.setGlobals(
                          currentUser: reauthenticatedUser!.user!,
                        );

                        if (!mounted) return;
                        context.pop();
                        context.pop();

                        buildConfirmationDialog(
                          context: context,
                          label: 'Delete Account',
                          buttonName: 'Delete Account',
                          message:
                              'Are you sure you want to delete your account? This action is irreversible!',
                          onAccept: () async {
                            try {
                              buildLoadingIndicator(
                                  context, 'Deleting Account');
                              await AuthService.firebase()
                                  .deleteUser(user: global.user!);

                              if (!mounted) return;
                              context.pop();
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => const Login(),
                                ),
                                (route) => false,
                              );
                            } catch (e) {
                              if (!mounted) return;
                              context.pop();
                              context.pop();
                              showErrorPopUp(e.toString(), context);
                            }
                          },
                        );
                      } catch (e) {
                        if (!mounted) return;
                        context.pop();
                        if (e is InvalidPasswordAuthException) {
                          showErrorPopUp('Incorrect Password', context);
                        } else {
                          showErrorPopUp(
                            e.toString(),
                            context,
                          );
                        }
                      }
                    },
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
              context.pop();
              buildLoadingIndicator(context, 'Logging Out');
              try {
                await AuthService.firebase().logout();
                if (!mounted) return;
                context.pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => const Login(),
                  ),
                  (route) => false,
                );
              } catch (e) {
                if (!mounted) return;
                context.pop();
                showErrorPopUp('Error logging out', context);
              }
            },
          ),
        ),
      ),
    );
  }
}
