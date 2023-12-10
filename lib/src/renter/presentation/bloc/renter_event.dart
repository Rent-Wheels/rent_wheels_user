part of 'renter_bloc.dart';

sealed class RenterEvent extends Equatable {
  const RenterEvent();

  @override
  List<Object> get props => [];
}

final class GetRenterDetailsEvent extends RenterEvent {
  final Map<String, dynamic> params;

  const GetRenterDetailsEvent({required this.params});
}
