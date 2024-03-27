import 'package:go_router/go_router.dart';
import 'package:rent_wheels/connection_page.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/login.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/forgot_password.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/signup.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/verify_email.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/reset_password_success.dart';
import 'package:rent_wheels/src/cars/presentation/pages/car_details.dart';
import 'package:rent_wheels/src/home/presentation/pages/base.dart';
import 'package:rent_wheels/src/onboarding/presentation/onboarding.dart';
import 'package:rent_wheels/src/user/presentation/pages/account_profile.dart';
import 'package:rent_wheels/src/user/presentation/pages/change_password.dart';

final GoRouter goRouterConfiguration = GoRouter(
  initialLocation: '/',
  routes: [
    //ROOT
    GoRoute(
      name: 'root',
      path: '/',
      builder: (context, state) => const ConnectionPage(),
    ),

    //ONBOARDING
    GoRoute(
      name: 'onboarding',
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    //SIGNUP
    GoRoute(
      name: 'signUp',
      path: '/signUp',
      builder: (context, state) => const SignUp(),
    ),

    //LOGIN
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const Login(),
      routes: [
        GoRoute(
          name: 'forgotPassword',
          path: 'forgot-password',
          builder: (context, state) => const ForgotPassword(),
        ),
      ],
    ),

    //VERIFY EMAIL
    GoRoute(
      name: 'verifyEmail',
      path: '/verify-email',
      builder: (context, state) => const VerifyEmail(),
    ),

    //RESET PASSWORD SUCCESS
    GoRoute(
      name: 'resetPasswordSuccess',
      path: '/reset-password-success',
      builder: (context, state) => ResetPasswordSuccess(
        email: state.uri.queryParameters['email'].toString(),
      ),
    ),

    //HOME
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const MainSection(),
    ),

    //CARS
    GoRoute(
      name: 'allCars',
      path: '/cars',
      builder: (context, state) => const MainSection(
        pageIndex: 1,
      ),
      routes: [
        GoRoute(
          name: 'carDetails',
          path: 'cars/:carId',
          builder: (context, state) => CarDetails(
            car: state.uri.queryParameters['car'].toString(),
            renter: state.uri.queryParameters['renter'].toString(),
            heroTag: state.uri.queryParameters['heroTag'],
          ),
        )
      ],
    ),

    //PROFILE
    GoRoute(
      name: 'allProfile',
      path: '/profile',
      builder: (context, state) => const MainSection(
        pageIndex: 3,
      ),
      routes: [
        GoRoute(
          name: 'accountProfile',
          path: 'account-profile',
          builder: (context, state) => const AccountProfile(),
        ),
        GoRoute(
          name: 'changePassword',
          path: 'change-password',
          builder: (context, state) => const ChangePassword(),
        ),
      ],
    ),
  ],
);
