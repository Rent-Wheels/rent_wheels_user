part of 'renter_bloc.dart';

sealed class RenterState extends Equatable {
  const RenterState();

  @override
  List<Object> get props => [];
}

final class RenterInitial extends RenterState {}

//!STATES
final class GetRenterDetailsLoading extends RenterState {}

final class GetRenterDetailsLoaded extends RenterState {
  final Renter renter;
  final bool? isNear;

  const GetRenterDetailsLoaded({required this.renter, this.isNear});
}

//!ERRORS
final class GenericRenterError extends RenterState {
  final String errorMessage;

  const GenericRenterError({required this.errorMessage});
}
