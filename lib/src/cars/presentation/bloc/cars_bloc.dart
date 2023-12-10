import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/cars/domain/entity/cars.dart';
import 'package:rent_wheels/src/cars/domain/usecase/get_all_available_cars.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final GetAllAvailableCars getAllAvailableCars;

  CarsBloc({required this.getAllAvailableCars}) : super(CarsInitial()) {
    on<GetAllAvailableCarsEvent>((event, emit) async {
      emit(GetAllAvailableCarsLoading());

      final response = await getAllAvailableCars(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericCarsError(errorMessage: errorMessage),
          (response) => GetAllAvailableCarsLoaded(cars: response),
        ),
      );
    });
  }
}
