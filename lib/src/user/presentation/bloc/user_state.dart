part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class GetUserRegionLoaded extends UserState {
  final String region;

  const GetUserRegionLoaded({required this.region});
}

final class GetCachedUserInfoLoaded extends UserState {
  final BackendUserInfo user;

  const GetCachedUserInfoLoaded({required this.user});
}

final class GenericUserError extends UserState {
  final String errorMessage;

  const GenericUserError({required this.errorMessage});
}
