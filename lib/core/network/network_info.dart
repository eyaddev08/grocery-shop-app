import 'package:connectivity_plus/connectivity_plus.dart';

/// Simple network info abstraction used by repositories to decide
/// whether to hit remote APIs or fallback to offline behaviour.
class NetworkInfo {
  final Connectivity _connectivity;

  NetworkInfo(this._connectivity);

  /// Returns `true` if we have at least one active network interface.
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}


