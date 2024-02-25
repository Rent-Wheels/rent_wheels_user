// import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/authentication/data/datasources/backend/localds.dart';
import 'package:rent_wheels/src/authentication/data/datasources/backend/remoteds.dart';
import 'package:rent_wheels/src/authentication/data/datasources/firebase/remoteds.dart';
import 'package:rent_wheels/src/authentication/domain/repository/backend/backend_authentication_repository.dart';
import 'package:rent_wheels/src/authentication/domain/repository/firebase/firebase_auth_repo.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

class AuthenticationRepositoryImpl
    implements
        FirebaseAuthenticationRepository,
        BackendAuthenticationRepository {
  final NetworkInfo networkInfo;
  final BackendAuthenticationLocalDatasource backendLocalDatasource;
  final BackendAuthenticationRemoteDatasource backendRemoteDatasource;
  final FirebaseAuthenticationRemoteDatasource firebaseRemoteDatasource;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.backendLocalDatasource,
    required this.backendRemoteDatasource,
    required this.firebaseRemoteDatasource,
  });

  @override
  Future<Either<String, BackendUserInfo>> createOrUpdateUser(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }
    try {
      final response = await backendRemoteDatasource.createOrUpdateUser(params);

      await backendLocalDatasource.cacheUserInfo(response);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response =
          await firebaseRemoteDatasource.createUserWithEmailAndPassword(
              email: params['email'], password: params['password']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteUserFromBackend(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }
    try {
      final response =
          await backendRemoteDatasource.deleteUserFromBackend(params);

      await backendLocalDatasource.deleteCachedUserInfo();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteUserFromFirebase(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await firebaseRemoteDatasource.deleteUserFromFirebase(
        user: params['user'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logout() async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await firebaseRemoteDatasource.logout();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserCredential>> reauthenticateUser(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await firebaseRemoteDatasource.reauthenticateUser(
        user: params['user'],
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> resetPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await firebaseRemoteDatasource.resetPassword(
        email: params['email'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserCredential>> signInWithEmailAndPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response =
          await firebaseRemoteDatasource.signInWithEmailAndPassword(
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateUserDetails(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await firebaseRemoteDatasource.updateUserDetails(
        user: params['user'],
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> verifyEmail(Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response =
          await firebaseRemoteDatasource.verifyEmail(user: params['user']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
