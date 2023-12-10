part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

//!BACKEND STATES
//!LOADING

final class CreateUpdateUserLoading extends AuthenticationState {}

final class DeleteUserFromBackendLoading extends AuthenticationState {}

//!LOADED
final class CreateUpdateUserLoaded extends AuthenticationState {
  final BackendUserInfo user;

  const CreateUpdateUserLoaded({required this.user});
}

final class DeleteUserFromBackendLoaded extends AuthenticationState {}

//!FIREBASE STATES
//!LOADING

final class CreateUserWithEmailAndPasswordLoading extends AuthenticationState {}

final class DeleteUserFromFirebaseLoading extends AuthenticationState {}

final class ReauthenticateUserLoading extends AuthenticationState {}

final class ResetPasswordLoading extends AuthenticationState {}

final class SignInWithEmailAndPasswordLoading extends AuthenticationState {}

final class UpdateUserLoading extends AuthenticationState {}

final class VerifyEmailLoading extends AuthenticationState {}

final class LogoutLoading extends AuthenticationState {}

//!LOADED

final class CreateUserWithEmailAndPasswordLoaded extends AuthenticationState {
  final UserCredential user;

  const CreateUserWithEmailAndPasswordLoaded({required this.user});
}

final class ReauthenticateUserLoaded extends AuthenticationState {
  final UserCredential user;

  const ReauthenticateUserLoaded({required this.user});
}

final class ResetPasswordLoaded extends AuthenticationState {}

final class SignInWithEmailAndPasswordLoaded extends AuthenticationState {
  final UserCredential user;

  const SignInWithEmailAndPasswordLoaded({required this.user});
}

final class DeleteUserFromFirebaseLoaded extends AuthenticationState {}

final class UpdateUserLoaded extends AuthenticationState {}

final class VerifyEmailLoaded extends AuthenticationState {}

final class InitializeFirebaseLoaded extends AuthenticationState {}

final class LogoutLoaded extends AuthenticationState {}

//!ERRORS
final class GenericFirebaseAuthError extends AuthenticationState {
  final String errorMessage;

  const GenericFirebaseAuthError({required this.errorMessage});
}

final class GenericBackendAuthError extends AuthenticationState {
  final String errorMessage;

  const GenericBackendAuthError({required this.errorMessage});
}
