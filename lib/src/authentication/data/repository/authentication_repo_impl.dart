import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/authentication/data/datasources/localds.dart';
import 'package:rent_wheels/src/authentication/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/authentication/domain/repository/backend/backend_authentication_repository.dart';
import 'package:rent_wheels/src/authentication/domain/repository/firebase/firebase_auth_repo.dart';
import 'package:rent_wheels/src/user/domain/entity/user_info.dart';

class AuthenticationRepositoryImpl
    implements
        FirebaseAuthenticationRepository,
        BackendAuthenticationRepository {
  final NetworkInfo networkInfo;
  final AuthenticationLocalDatasource localDatasource;
  final AuthenticationRemoteDatasourceImpl remoteDatasource;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<String, BackendUserInfo>> createOrUpdateUser(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }
    try {
      final response = await remoteDatasource.createOrUpdateUser(params);

      await localDatasource.cacheUserInfo(response);

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
      final response = await remoteDatasource.createUserWithEmailAndPassword(
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left('Please choose a stronger password');
      }
      if (e.code == 'email-already-in-use') {
        return const Left('Email is already in use');
      }
      return Left(e.toString());
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
      final response = await remoteDatasource.deleteUserFromBackend(params);

      await localDatasource.deleteCachedUserInfo();

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
      final response = await remoteDatasource.deleteUserFromFirebase(
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
      final response = await remoteDatasource.logout();

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
      final response = await remoteDatasource.reauthenticateUser(
        user: params['user'],
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return const Left('Incorrect password');
      }
      return Left(e.toString());
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
      final response = await remoteDatasource.resetPassword(
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
      final response = await remoteDatasource.signInWithEmailAndPassword(
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left('User does not exist');
      }
      if (e.code == 'wrong-password') {
        return const Left('Invalid email or password');
      }
      return Left(e.toString());
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
      final response = await remoteDatasource.updateUserDetails(
        user: params['user'],
        email: params['email'],
        password: params['password'],
      );

      return Right(response);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return const Left('Invalid email or password');
      }
      return Left(e.toString());
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
      final response = await remoteDatasource.verifyEmail(user: params['user']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
