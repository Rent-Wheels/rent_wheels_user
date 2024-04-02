part of 'cars_bloc.dart';

sealed class CarsState extends Equatable {
  const CarsState();

  @override
  List<Object> get props => [];
}

final class CarsInitial extends CarsState {}

final class GetAllAvailableCarsLoading extends CarsState {}

final class GetAllAvailableCarsLoaded extends CarsState {
  final List<Car> cars;

  const GetAllAvailableCarsLoaded({required this.cars});
}

final class GenericCarsError extends CarsState {
  final String errorMessage;

  const GenericCarsError({required this.errorMessage});
}
