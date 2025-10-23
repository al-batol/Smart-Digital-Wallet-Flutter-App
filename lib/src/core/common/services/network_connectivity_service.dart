import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivityService {
  final Connectivity connectivity;

  NetworkConnectivityService({required this.connectivity});

  Future<bool> hasConnection() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet);
  }

  Future<void> checkConnection(Exception exception) async {
    final hasInternet = await hasConnection();
    if (!hasInternet) {
      throw exception;
    }
  }
}
