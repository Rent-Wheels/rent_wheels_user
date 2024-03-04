import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rent_wheels/injection.dart';
import 'package:rent_wheels/src/global/presentation/provider/global_provider.dart';
import 'package:rent_wheels/src/loading/loading.dart';
import 'package:rent_wheels/src/user/presentation/bloc/user_bloc.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  User? user;
  final userBloc = sl<UserBloc>();
  // bool firstTime = true;
  // Future<bool> getOnboardingStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool('firstTime')!;
  // }

  userStatus() async {
    // firstTime = await getOnboardingStatus();

    if (!context.read<GlobalProvider>().onboardingStatus) {
      context.goNamed(
        'onboarding',
        queryParameters: {
          'onboarding': 'true',
        },
      );
      return;
    }

    user = context.read<GlobalProvider>().user;

    context.read<GlobalProvider>().updateHeaders();

    final params = {
      'urlParameters': {
        'userId': user?.uid,
      },
      'headers': context.read<GlobalProvider>().headers
    };

    userBloc.add(
      GetUserDetailsEvent(
        params: params,
      ),
    );
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
