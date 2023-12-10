part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object> get props => [];
}

final class GetAllAvailableCarsEvent extends CarsEvent {
  final Map<String, dynamic> params;

  const GetAllAvailableCarsEvent({required this.params});
}
