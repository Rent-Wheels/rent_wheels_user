import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/loading/loading.dart';
import 'package:rent_wheels/src/user/presentation/bloc/user_bloc.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  User? user;
  final userBloc = sl<UserBloc>();

  userStatus() async {
    if (!context.read<GlobalProvider>().onboardingStatus) {
      context.goNamed('onboarding');
      return;
    }

    user = context.read<GlobalProvider>().currentUser;

    context.read<GlobalProvider>().updateHeaders();

    final params = {
      'urlParameters': {
        'userId': user?.uid,
      },
      'headers': context.read<GlobalProvider>().headers
    };

    userBloc.add(GetUserDetailsEvent(params: params));
  }

  @override
  void initState() {
    userStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: userBloc,
      listener: (context, state) {
        if (state is GenericUserError) {
          context.goNamed('login');
        }
        if (state is GetUserDetailsLoaded) {
          context.read<GlobalProvider>().updateUserDetails(state.user);
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
