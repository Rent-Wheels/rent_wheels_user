part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//!BACKEND EVENTS

final class CreateOrUpdateUserEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const CreateOrUpdateUserEvent({required this.params});
}

final class DeleteUserFromBackendEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const DeleteUserFromBackendEvent({required this.params});
}

//!FIREBASE EVENTS
final class CreateUserWithEmailAndPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const CreateUserWithEmailAndPasswordEvent({required this.params});
}

final class DeleteUserFromFirebaseEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const DeleteUserFromFirebaseEvent({required this.params});
}

final class ReauthenticateUserEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const ReauthenticateUserEvent({required this.params});
}

final class ResetPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const ResetPasswordEvent({required this.params});
}

final class SignInWithEmailAndPasswordEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const SignInWithEmailAndPasswordEvent({required this.params});
}

final class UpdateUserEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const UpdateUserEvent({required this.params});
}

final class VerifyEmailEvent extends AuthenticationEvent {
  final Map<String, dynamic> params;

  const VerifyEmailEvent({required this.params});
}

final class InitializeFirebaseEvent extends AuthenticationEvent {}

final class LogoutEvent extends AuthenticationEvent {}
