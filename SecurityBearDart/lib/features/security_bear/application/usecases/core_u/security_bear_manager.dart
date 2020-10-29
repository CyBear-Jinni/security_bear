import 'package:SecurityBearDart/core/helper_methods.dart';
import 'package:SecurityBearDart/features/security_bear/application/usecases/network_actions/network_actions.dart';
import 'package:SecurityBearDart/features/security_bear/application/usecases/security_bear_server_u/security_bear_server_u.dart';
import 'package:grpc/grpc.dart';

/// This class is where all the program start after the main file
class SecurityBearManagerU {
  SecurityBearManagerU() {
    securityBearMainAsync();
  }

  Future<void> securityBearMainAsync() async {
    print('Device local IP: ${await getIps()}');

    createServer();
    connectToDatabase();

    manegeNetworkConnection();
  }

  ///  This function starts the object
  ///  to manege the state of the device network connection
  Future<void> manegeNetworkConnection() async {
    NetworkActions networkActions = NetworkActions(
        'AndroidAP_6194', '7f1ee6787744', 'WiFi-ssid', 'WiFi-password');

    await networkActions.connectToAdminWhenExist();
  }

  /// This function connect to the data base
  void connectToDatabase() {}

  ///  This function will create the server in case there is connection
  Future<void> createServer() async {
    final server = Server([SecurityBearServerU()]);
    await server.serve(port: 50052);
    print('Server listening on port ${server.port}...');
  }
}
