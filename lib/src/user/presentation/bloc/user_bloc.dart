import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_cached_user_info.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_user_details.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_user_region.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserRegion getUserRegion;
  final GetUserDetails getUserDetails;
  final GetCachedUserInfo getCachedUserInfo;

  UserBloc({
    required this.getUserRegion,
    required this.getUserDetails,
    required this.getCachedUserInfo,
  }) : super(UserInitial()) {
    //!GET USER REGION
    on<GetUserRegionEvent>((event, emit) async {
      final response = await getUserRegion(NoParams());

      emit(
        response.fold(
          (errorMessage) => GenericUserError(errorMessage: errorMessage),
          (response) => GetUserRegionLoaded(region: response),
        ),
      );
    });

    //!GET USER DETAILS
    on<GetUserDetailsEvent>((event, emit) async {
      final response = await getUserDetails(event.params);

      emit(
        response.fold(
          (errorMessage) => GenericUserError(errorMessage: errorMessage),
          (response) => GetUserDetailsLoaded(user: response),
        ),
      );
    });

    //!GET CACHED USER DETAILS
    on<GetCachedUserInfoEvent>((event, emit) async {
      final response = await getCachedUserInfo(NoParams());

      emit(
        response.fold(
          (errorMessage) => GenericUserError(errorMessage: errorMessage),
          (response) => GetCachedUserInfoLoaded(user: response),
        ),
      );
    });
  }
}
