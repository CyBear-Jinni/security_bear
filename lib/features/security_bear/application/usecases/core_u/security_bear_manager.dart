import 'package:grpc/grpc.dart';
import 'package:security_bear/features/security_bear/application/usecases/network_actions/network_actions.dart';
import 'package:security_bear/features/security_bear/application/usecases/security_bear_server_u/security_bear_server_u.dart';
import 'package:security_bear/features/security_bear/infrastructure/core/network_entity.dart';
import 'package:security_bear/infrastructure/core/helper_methods.dart';
import 'package:security_bear/injection.dart';

/// This class is where all the program start after the main file
class SecurityBearManagerU {
  /// Port for the security bear server to get opened on
  static late int securityBearServerPort;

  final NetworkEntity firstAndAdminNetworkDefault =
      NetworkEntity(networkName: 'CyBear Jinni', networkPass: 'CyBear Jinni');

  final NetworkEntity secondNetworkDefault = NetworkEntity(
      networkName: 'CyBear_Jinni Jinni', networkPass: 'CyBear_Jinni Jinni');

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
    final NetworkActions networkActions =
        NetworkActions(firstAndAdminNetworkDefault, secondNetworkDefault);

    await networkActions.connectToAdminWhenExist();
  }

  /// This function connect to the data base
  void connectToDatabase() {}

  ///  This function will create the server in case there is connection
  Future<void> createServer() async {
    final server = Server([SecurityBearServerU()]);
    if (currentEnv == Env.prod) {
      securityBearServerPort = 50052;
    } else {
      securityBearServerPort = 60052;
    }
    await server.serve(port: securityBearServerPort);
    print('Server listening on port ${server.port}...');
  }
}
