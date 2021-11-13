import 'package:grpc/grpc.dart';
import 'package:security_bear_dart/data_base/cbj_app/protoc_as_dart/cbj_app_connections.pbgrpc.dart';

/// Class to manage calls to the CBJApp server
class CBJAppClient {
  /// Will Send the IP of this device to server in the connected network
  static Future<bool?> SendMyIPToServer(
      String serverIp, String myDeviceIP) async {
    final ClientChannel channel = createCBJAppClient(serverIp);
    final CyBearJinniAppClient stub = CyBearJinniAppClient(channel);
    CBJCommendStatus responseSBCommendStatus = CBJCommendStatus();

    final CompInfoSB smartDeviceInfo = CompInfoSB()..compIP = myDeviceIP;

    try {
      responseSBCommendStatus =
          await stub.cBJAppGetSmartDeviceInformation(smartDeviceInfo);

      print('Greeter client received: ${responseSBCommendStatus.toString()}');
//      await channel.shutdown();
      return Future.value(responseSBCommendStatus.success);
    } catch (e) {
      print('Caught error: $e');
    }
//    await channel.shutdown();
    return null;
  }

  static ClientChannel createCBJAppClient(String serverIp) {
    return ClientChannel(serverIp,
        port: 30055,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));
  }
}
