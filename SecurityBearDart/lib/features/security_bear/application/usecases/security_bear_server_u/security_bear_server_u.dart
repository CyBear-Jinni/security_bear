import 'package:SecurityBearDart/features/security_bear/application/usecases/network_actions/network_actions.dart';
import 'package:SecurityBearDart/features/security_bear/infrastructure/datasources/security_bear_server_d/protoc_as_dart/security_bear_connections.pbgrpc.dart';
import 'package:grpc/src/server/call.dart';

class SecurityBearServerU extends SecurityBearServiceBase {
  @override
  Future<SBCommendStatus> setWiFiInformation(
      ServiceCall call, SecurityBearSetup request) {
    print('Set WiFi information');

    WiFiInformation wiFiInformationFirstP = request.wiFiSecondPriority;

    print('WiFi name: ${wiFiInformationFirstP.wiFiName}, WiFi password:'
        ' ${wiFiInformationFirstP.wiFiPassword}');

    NetworkActions.wiFiName = wiFiInformationFirstP.wiFiName;
    NetworkActions.wiFiPassword = wiFiInformationFirstP.wiFiPassword;
  }

  @override
  Future<SBCommendStatus> setFirebaseAccountAndSecurityBearSetup(
      ServiceCall call, SBFirebaseAccountAndSecurityBearSetup request) {
    final SecurityBearSetup securityBearSetup = request.securityBearSetup;
    final WiFiInformation wiFiInformationFirstP =
        securityBearSetup.wiFiFirstPriority;
    final WiFiInformation wiFiInformationSecondP =
        securityBearSetup.wiFiSecondPriority;

    print('WiFi name: ${wiFiInformationFirstP.wiFiName}, WiFi password:'
        ' ${wiFiInformationFirstP.wiFiPassword}');

    NetworkActions.adminWiFiName = wiFiInformationFirstP.wiFiName;
    NetworkActions.adminWiFiPass = wiFiInformationFirstP.wiFiPassword;

    NetworkActions.wiFiName = wiFiInformationSecondP.wiFiName;
    NetworkActions.wiFiPassword = wiFiInformationSecondP.wiFiPassword;
  }
}
