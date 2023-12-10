import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rent_wheels/core/usecase/usecase.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_cached_user_info.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_user_region.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCachedUserInfo getCachedUserInfo;
  final GetUserRegion getUserRegion;

  UserBloc({
    required this.getCachedUserInfo,
    required this.getUserRegion,
  }) : super(UserInitial()) {
    on<GetCachedUserInfoEvent>((event, emit) async {
      final response = await getCachedUserInfo(NoParams());

      emit(
        response.fold(
          (errorMessage) => GenericUserError(errorMessage: errorMessage),
          (response) => GetCachedUserInfoLoaded(user: response),
        ),
      );
    });

    on<GetUserRegionEvent>((event, emit) async {
      final response = await getUserRegion(NoParams());

      emit(
        response.fold(
          (errorMessage) => GenericUserError(errorMessage: errorMessage),
          (response) => GetUserRegionLoaded(region: response),
        ),
      );
    });
  }
}
