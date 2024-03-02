import 'package:go_router/go_router.dart';
import 'package:rent_wheels/connection_page.dart';
import 'package:rent_wheels/src/authentication/login/presentation/login.dart';
import 'package:rent_wheels/src/authentication/verify/presentation/verify_email.dart';
import 'package:rent_wheels/src/mainSection/base.dart';

final GoRouter goRouterConfiguration = GoRouter(
  initialLocation: '/',
  routes: [
    //ROOT
    GoRoute(
      name: 'root',
      path: '/',
      builder: (context, state) => const ConnectionPage(),
    ),

    //LOGIN
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
    ),

    //VERIFY EMAIL
    GoRoute(
      name: 'verifyEmail',
      path: '/verify-email',
      builder: (context, state) => const VerifyEmail(),
    ),

    //HOME
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const MainSection(),
    ),
  ],
);
