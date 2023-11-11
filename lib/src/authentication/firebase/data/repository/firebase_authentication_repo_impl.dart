import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rent_wheels/core/network/network_info.dart';
import 'package:rent_wheels/src/authentication/firebase/data/datasources/remoteds.dart';
import 'package:rent_wheels/src/authentication/firebase/domain/repository/firebase_auth_repo.dart';

class FirebaseAuthenticationRepositoryImpl
    implements FirebaseAuthenticationRepository {
  final NetworkInfo networkInfo;
  final FirebaseAuthenticationRemoteDatasource remoteDatasource;

  FirebaseAuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.remoteDatasource,
  });
  // logout
  @override
  Future<Either<String, UserCredential>> createUserWithEmailAndPassword(
      Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.createUserWithEmailAndPassword(
          email: params['email'], password: params['password']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
  // initialize firebase

  @override
  Future<Either<String, void>> deleteUser(Map<String, dynamic> params) async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.deleteUser(user: params['user']);

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// create user with email and password
  @override
  Future<Either<String, void>> initialize() async {
    if (!(await networkInfo.isConnected)) {
      return Left(networkInfo.noNetworkMessage);
    }

    try {
      final response = await remoteDatasource.initialize();

      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// sign in with email and password
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

  /// verify user
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// reset password
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

  /// delete user
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// reauthenticate user
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
    } catch (e) {
      return Left(e.toString());
    }
  }

  /// update user details
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
