import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class CheckNetworkInterface {
  Future<bool> get isConect;
}

class NetworkInfo implements CheckNetworkInterface {
  late InternetConnectionChecker connectionChecker;
  NetworkInfo(this.connectionChecker);
  @override
  Future<bool> get isConect => connectionChecker.hasConnection;
}

Future<bool> checkInternetConnecation() async =>
    InternetConnectionChecker().hasConnection;
