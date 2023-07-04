import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rent_wheels/src/mainSection/profile/widgets/profile_options_widget.dart';
import 'package:rent_wheels/src/mainSection/profile/presentation/sections/accountProfile/presentation/account_profile.dart';
import 'package:rent_wheels/src/mainSection/profile/presentation/sections/changePassword/presentation/change_password.dart';

import 'package:rent_wheels/core/auth/auth_service.dart';
import 'package:rent_wheels/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels/core/widgets/theme/colors.dart';
import 'package:rent_wheels/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels/core/global/globals.dart' as global;
import 'package:rent_wheels/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels/src/authentication/login/presentation/login.dart';
import 'package:rent_wheels/core/widgets/loadingIndicator/loading_indicator.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    RentWheelsUserMethods().getUserDetails(userId: global.user!.uid).then(
        (userDetails) => global.setGlobals(fetchedUserDetails: userDetails));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile",
                style: heading3Information,
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
                          '${global.baseURL}/${global.userDetails!.profilePicture}',
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
                        style: heading5Neutral,
                      ),
                      Space().height(context, 0.005),
                      Text(
                        global.userDetails!.email,
                        style: heading6Neutral900,
                      ),
                    ],
                  )
                ],
              ),
              Space().height(context, 0.03),
              buildProfileOptions(
                context: context,
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
              buildProfileOptions(
                context: context,
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
              buildProfileOptions(
                context: context,
                section: 'Notifications',
                svg: 'assets/svgs/notifications.svg',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: Sizes().height(context, 0.1),
        color: rentWheelsNeutralLight0,
        child: buildGenericButtonWidget(
          width: Sizes().width(context, 0.85),
          isActive: true,
          buttonName: 'Logout',
          context: context,
          onPressed: () async {
            buildLoadingIndicator(context, 'Logging Out');
            try {
              await AuthService.firebase().logout();
              if (!mounted) return;
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (context) => const Login(),
                ),
                (route) => false,
              );
            } catch (e) {
              if (!mounted) return;
              Navigator.pop(context);
              showErrorPopUp('Error logging out', context);
            }
          },
        ),
      ),
    );
  }
}
