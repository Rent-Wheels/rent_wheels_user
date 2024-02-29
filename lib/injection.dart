import 'package:http/http.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

import 'package:rent_wheels/core/urls/urls.dart';
import 'package:rent_wheels/core/network/network_info.dart';

import 'package:rent_wheels/src/authentication/data/datasources/localds.dart';
import 'package:rent_wheels/src/authentication/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/logout.dart';
import 'package:rent_wheels/src/authentication/data/datasources/backend/localds.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/update_user.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/verify_email.dart';
import 'package:rent_wheels/src/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/reset_password.dart';
import 'package:rent_wheels/src/authentication/data/repository/authentication_repo_impl.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/backend/create_update_user.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/reauthenticate_user.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/backend/delete_user_from_backend.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/sign_in_with_email_and_password.dart';
import 'package:rent_wheels/src/authentication/domain/usecase/firebase/create_user_with_email_and_password.dart';

import 'package:rent_wheels/src/cars/data/datasource/remoteds.dart';
import 'package:rent_wheels/src/cars/presentation/bloc/cars_bloc.dart';
import 'package:rent_wheels/src/cars/data/repository/car_repo_impl.dart';
import 'package:rent_wheels/src/cars/domain/repository/car_repository.dart';
import 'package:rent_wheels/src/cars/domain/usecase/get_all_available_cars.dart';

import 'package:rent_wheels/src/files/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/files/domain/usecases/delete_file.dart';
import 'package:rent_wheels/src/files/domain/usecases/get_file_url.dart';
import 'package:rent_wheels/src/files/presentation/bloc/files_bloc.dart';
import 'package:rent_wheels/src/files/domain/usecases/delete_directory.dart';
import 'package:rent_wheels/src/files/domain/repository/file_repository.dart';
import 'package:rent_wheels/src/files/data/repository/files_repository_impl.dart';

import 'package:rent_wheels/src/renter/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/renter/presentation/bloc/renter_bloc.dart';
import 'package:rent_wheels/src/renter/data/repository/renter_repo_impl.dart';
import 'package:rent_wheels/src/renter/domain/usecases/get_renter_details.dart';
import 'package:rent_wheels/src/renter/domain/repository/renter_repository.dart';

import 'package:rent_wheels/src/reservations/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/reservations/domain/usecases/make_reservation.dart';
import 'package:rent_wheels/src/reservations/presentation/bloc/reservations_bloc.dart';
import 'package:rent_wheels/src/reservations/domain/usecases/get_all_reservations.dart';
import 'package:rent_wheels/src/reservations/data/repository/reservations_repo_impl.dart';
import 'package:rent_wheels/src/reservations/domain/repository/reservations_repository.dart';
import 'package:rent_wheels/src/reservations/domain/usecases/change_reservation_status.dart';

import 'package:rent_wheels/src/user/data/datasource/localds.dart';
import 'package:rent_wheels/src/user/data/datasource/remoteds.dart';
import 'package:rent_wheels/src/user/presentation/bloc/user_bloc.dart';
import 'package:rent_wheels/src/user/data/repository/user_repo_impl.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_user_region.dart';
import 'package:rent_wheels/src/user/domain/repository/user_repository.dart';
import 'package:rent_wheels/src/user/domain/usecase/get_cached_user_info.dart';

final sl = GetIt.instance;

init() async {
  //!INTERNAL

  //AUTHENTICATION
  initAuth();

  //CARS
  initCars();

  //FILES
  initFiles();

  //RENTER
  initRenter();

  //RESERVATIONS
  initReservations();

  //USER
  initUser();

  //!EXTERNAL

  //LOCAL STORAGE
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(
    () => sharedPreferences,
  );

  //FIREBASE
  sl
    ..registerLazySingleton(
      () => FirebaseAuth.instance,
    )
    ..registerLazySingleton(
      () => FirebaseStorage.instance,
    );

  //NETWORK RESOURCES
  sl
    ..registerLazySingleton(
      () => Client(),
    )
    ..registerLazySingleton(
      () => Urls(),
    )
    ..registerLazySingleton(
      () => DataConnectionChecker(),
    )
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        dataConnectionChecker: sl(),
      ),
    );
}

//AUTHENTICATION
initAuth() {
  //bloc
  sl.registerFactory(
    () => AuthenticationBloc(
      logout: sl(),
      verifyEmail: sl(),
      resetPassword: sl(),
      updateUserDetails: sl(),
      reauthenticateUser: sl(),
      createOrUpdateUser: sl(),
      deleteUserFromBackend: sl(),
      deleteUserFromFirebase: sl(),
      signInWithEmailAndPassword: sl(),
      createUserWithEmailAndPassword: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => Logout(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => VerifyEmail(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ResetPassword(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateUserDetails(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ReauthenticateUser(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateOrUpdateUser(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteUserFromBackend(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignInWithEmailAndPassword(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateUserWithEmailAndPassword(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton(
    () => AuthenticationRepositoryImpl(
      networkInfo: sl(),
      backendLocalDatasource: sl(),
      backendRemoteDatasource: sl(),
      firebaseRemoteDatasource: sl(),
    ),
  );

  //datasources
  sl
    ..registerLazySingleton(
      () => AuthenticationRemoteDatasourceImpl(
        client: sl(),
        url: sl(),
        firebase: sl(),
      ),
    )
    ..registerLazySingleton<BackendAuthenticationLocalDatasource>(
      () => AuthenticationLocalDatasource(
        sharedPreferences: sl(),
      ),
    );
}

//CARS
initCars() {
  //bloc
  sl.registerFactory(
    () => CarsBloc(
      getAllAvailableCars: sl(),
    ),
  );

  //usecases
  sl.registerLazySingleton(
    () => GetAllAvailableCars(
      repository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<CarRepository>(
    () => CarRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<CarsRemoteDatasource>(
    () => CarsRemoteDatasourceImpl(
      urls: sl(),
      client: sl(),
    ),
  );
}

//FILES
initFiles() {
  //bloc
  sl.registerFactory(
    () => FilesBloc(
      getFileUrl: sl(),
      deleteFile: sl(),
      deleteDirectory: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => GetFileUrl(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteFile(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => DeleteDirectory(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton<FileRepository>(
    () => FileRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<FilesRemoteDatasource>(
    () => FilesRemoteDatasourceImpl(
      storage: sl(),
    ),
  );
}

//RENTER
initRenter() {
  //bloc
  sl.registerFactory(
    () => RenterBloc(
      getRenterDetails: sl(),
    ),
  );

  //usecases
  sl.registerLazySingleton(
    () => GetRenterDetails(
      repository: sl(),
    ),
  );

  //repository
  sl.registerLazySingleton<RenterRepository>(
    () => RenterRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<RenterRemoteDatasource>(
    () => RenterRemoteDatasourceImpl(
      urls: sl(),
      client: sl(),
    ),
  );
}

//RESERVATIONS
initReservations() {
  //bloc
  sl.registerFactory(
    () => ReservationsBloc(
      makeReservation: sl(),
      getAllReservations: sl(),
      changeReservationStatus: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => MakeReservation(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetAllReservations(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ChangeReservationStatus(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton<ReservationsRepository>(
    () => ReservationsRepositoryImpl(
      networkInfo: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<ReservationsRemoteDatasource>(
    () => ReservationsRemoteDatasourceImpl(
      client: sl(),
      urls: sl(),
    ),
  );
}

//USER
initUser() {
  //bloc
  sl.registerFactory(
    () => UserBloc(
      getCachedUserInfo: sl(),
      getUserRegion: sl(),
    ),
  );

  //usecases
  sl
    ..registerLazySingleton(
      () => GetCachedUserInfo(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetUserRegion(
        repository: sl(),
      ),
    );

  //repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      networkInfo: sl(),
      localDatasource: sl(),
      remoteDatasource: sl(),
    ),
  );

  //datasources
  sl
    ..registerLazySingleton<UserRemoteDatasource>(
      () => UserRemoteDatasourceImpl(
        client: sl(),
        urls: sl(),
      ),
    )
    ..registerLazySingleton<UserLocalDatasource>(
      () => UserLocalDatasourceImpl(
        sharedPreferences: sl(),
      ),
    );
}
