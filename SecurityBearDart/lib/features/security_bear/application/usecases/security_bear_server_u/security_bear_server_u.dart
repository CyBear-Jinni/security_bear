import 'package:security_bear_dart/features/security_bear/application/usecases/network_actions/network_actions.dart';
import 'package:security_bear_dart/features/security_bear/infrastructure/datasources/security_bear_server_d/protoc_as_dart/security_bear_connections.pbgrpc.dart';
import 'package:grpc/src/server/call.dart';

class SecurityBearServerU extends SecurityBearServiceBase {
  @override
  Future<SBCommendStatus> setFirebaseAccountInformation(ServiceCall call, SBFirebaseAccountInformation request) {
    print('Setting fire base account');
    // TODO: implement setFirebaseAccountInformation
    throw UnimplementedError();
  }

  @override
  Future<SBCommendStatus> setWiFiInformation(ServiceCall call, SecurityBearSetup request) {
    print('Set WiFi information');

    WiFiInformation wiFiInformationFirstP = request.wiFiSecondPriority;

    print('WiFi name: ${wiFiInformationFirstP.wiFiName}, WiFi password:'
        ' ${wiFiInformationFirstP.wiFiPassword}');

    NetworkActions.wiFiName = wiFiInformationFirstP.wiFiName;
    NetworkActions.wiFiPassword = wiFiInformationFirstP.wiFiPassword;
  }
}
