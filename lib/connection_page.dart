import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/loading.dart';
import 'package:rent_wheels/src/user/presentation/bloc/user_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  User? user;
  late GlobalProvider _globalProvider;
  final userBloc = sl<UserBloc>();

  userStatus() {
    user = _globalProvider.currentUser;

    _globalProvider.updateHeaders(user);

    final params = {
      'urlParameters': {
        'userId': user?.uid,
      },
      'headers': _globalProvider.headers
    };

    userBloc.add(GetUserDetailsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    _globalProvider = context.watch<GlobalProvider>();
    userStatus();
    return BlocListener(
      bloc: userBloc,
      listener: (context, state) {
        if (state is GenericUserError) {
          _globalProvider.onboardingStatus
              ? context.goNamed('login')
              : context.goNamed('onboarding');
        }
        if (state is GetUserDetailsLoaded) {
          _globalProvider.reloadCurrentUser();
          _globalProvider.updateUserDetails(state.user);
          if (user!.emailVerified) {
            context.goNamed('home');
          } else {
            context.goNamed('verifyEmail');
          }
        }
      },
      child: const LoadingScreen(),
    );
  }
}
