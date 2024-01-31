import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:security_bear/features/security_bear/infrastructure/core/network_entity.dart';

class MySingleton {
  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal() {
    smartWiFiList = <NetworkEntity>[];
    getUuid();
    getCurrentUserName();
  }

  static final MySingleton _singleton = MySingleton._internal();
  static List<NetworkEntity>? smartWiFiList;
  static Future<String>? _deviceUid;
  static Future<String>? _currentUserName;
  static Future<String>? _localDbPath;

  static Future<String> getUuid() =>
      _deviceUid ??= SystemCommandsBaseClassD.instance.getUuidOfCurrentDevice();

  static Future<String?> getCurrentUserName() => _currentUserName ??=
      SystemCommandsBaseClassD.instance.getCurrentUserName();

  static Future<String?> getLocalDbPath() =>
      _localDbPath ??= SystemCommandsBaseClassD.instance.getLocalDbPath();

  static void addToNetworksList(NetworkEntity smartNetworksVal) {
    smartWiFiList!.add(smartNetworksVal);
  }
}

class FirebaseAccountInformationFlutter {
  FirebaseAccountInformationFlutter(
    this.fireBaseProjectId,
    this.fireBaseApiKey,
    this.userEmail,
    this.userPassword,
  );

  String fireBaseProjectId;
  String fireBaseApiKey;
  String userEmail;
  String userPassword;

  bool areAllValuesNotEmpty() {
    return fireBaseProjectId.isNotEmpty &&
        fireBaseApiKey.isNotEmpty &&
        userEmail.isNotEmpty &&
        userPassword.isNotEmpty;
  }
}
