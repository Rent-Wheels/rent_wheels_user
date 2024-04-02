import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels/src/renter/domain/entity/renter.dart';
import 'package:rent_wheels/src/renter/domain/usecases/get_renter_details.dart';

part 'renter_event.dart';
part 'renter_state.dart';

class RenterBloc extends Bloc<RenterEvent, RenterState> {
  final GetRenterDetails getRenterDetails;

  RenterBloc({required this.getRenterDetails}) : super(RenterInitial()) {
    on<GetRenterDetailsEvent>((event, emit) async {
      emit(GetRenterDetailsLoading());

      final response = await getRenterDetails(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericRenterError(errorMessage: errorMessage),
          (response) => GetRenterDetailsLoaded(
            renter: response,
            isNear: event.params['isNear'],
          ),
        ),
      );
    });
  }
}
