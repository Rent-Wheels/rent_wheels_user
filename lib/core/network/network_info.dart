import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  String get noNetworkMessage;
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final DataConnectionChecker dataConnectionChecker;

  NetworkInfoImpl({required this.dataConnectionChecker});

  @override
  Future<bool> get isConnected => dataConnectionChecker.hasConnection;

  @override
  String get noNetworkMessage => 'Please check your internet connection';
}
