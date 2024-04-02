import 'package:go_router/go_router.dart';
import 'package:rent_wheels/connection_page.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/login.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/forgot_password.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/signup.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/verify_email.dart';
import 'package:rent_wheels/src/authentication/presentation/pages/reset_password_success.dart';
import 'package:rent_wheels/src/cars/presentation/pages/car_details.dart';
import 'package:rent_wheels/src/home/presentation/pages/base.dart';
import 'package:rent_wheels/src/payment/presentation/pages/payment.dart';
import 'package:rent_wheels/src/onboarding/presentation/onboarding.dart';
import 'package:rent_wheels/src/renter/presentation/pages/renter_profile.dart';
import 'package:rent_wheels/src/reservations/presentation/pages/make_reservation_page_one.dart';
import 'package:rent_wheels/src/reservations/presentation/pages/make_reservation_page_two.dart';
import 'package:rent_wheels/src/reservations/presentation/pages/reservation_successful.dart';
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
          path: ':carId',
          builder: (context, state) => CarDetails(
            car: state.uri.queryParameters['car'].toString(),
            renter: state.uri.queryParameters['renter'].toString(),
            heroTag: state.uri.queryParameters['heroTag'],
          ),
          routes: [
            GoRoute(
              name: 'renterDetails',
              path: 'renter',
              builder: (context, state) => RenterDetails(
                renter: state.uri.queryParameters['renter'].toString(),
              ),
            )
          ],
        )
      ],
    ),

    //RESERVATIONS
    GoRoute(
      name: 'reservations',
      path: '/reservations',
      builder: (context, state) => const MainSection(
        pageIndex: 2,
      ),
      routes: [
        GoRoute(
          name: 'makeReservation',
          path: 'make-reservation',
          builder: (context, state) => MakeReservationPageOne(
            car: state.uri.queryParameters['car'],
          ),
          routes: [
            GoRoute(
              name: 'makeReservationConfirmation',
              path: 'confirmation',
              builder: (context, state) => MakeReservationPageTwo(
                view: ReservationView.make,
                car: state.uri.queryParameters['car'],
                renter: state.uri.queryParameters['renter'],
                reservation:
                    state.uri.queryParameters['reservation'].toString(),
              ),
            ),
          ],
        ),
        GoRoute(
          name: 'reservationSuccess',
          path: 'success',
          builder: (context, state) => const ReservationSuccessful(),
        ),
        GoRoute(
            name: 'reservationDetails',
            path: ':reservationId',
            builder: (context, state) => MakeReservationPageTwo(
                  view: ReservationView.view,
                  car: state.uri.queryParameters['car'],
                  renter: state.uri.queryParameters['renter'],
                  reservation:
                      state.uri.queryParameters['reservation'].toString(),
                ),
            routes: [
              //PAYMENT
              GoRoute(
                name: 'payment',
                path: 'payment',
                builder: (context, state) => Payment(
                  car: state.uri.queryParameters['car'].toString(),
                  reservation:
                      state.uri.queryParameters['reservation'].toString(),
                ),
              ),
            ]),
      ],
    ),

    //PROFILE
    GoRoute(
      name: 'profile',
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
