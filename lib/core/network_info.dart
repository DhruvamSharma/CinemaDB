import 'package:internet_connection_checker/internet_connection_checker.dart';

/// This class will be used for checking the network connectivity,
/// If there is a reliable network connection or not.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl({
    required this.connectionChecker,
  });

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
