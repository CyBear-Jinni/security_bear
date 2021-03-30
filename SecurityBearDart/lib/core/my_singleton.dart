import 'package:security_bear_dart/core/my_singleton_helper.dart';
import 'package:security_bear_dart/features/security_bear/infrastructure/core/NetworkEntity.dart';

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
  static List<NetworkEntity> smartWiFiList;
  static Future<String> _deviceUid;
  static Future<String> _currentUserName;

  static Future<String> getUuid() => _deviceUid ??= MySingletonHelper.getUuid();

  static Future<String> getCurrentUserName() =>
      _currentUserName ??= MySingletonHelper.getCurrentUserName();

  static void setNetworksList(List<NetworkEntity> smartNetworksListVal) {
    smartWiFiList = smartNetworksListVal;
  }

  static void addToNetworksList(NetworkEntity smartNetworksVal) {
    smartWiFiList.add(smartNetworksVal);
  }

  static List<NetworkEntity> getSmartNetworksList() => smartWiFiList;
}

class FirebaseAccountInformationFlutter {
  FirebaseAccountInformationFlutter(this.fireBaseProjectId, this.fireBaseApiKey,
      this.userEmail, this.userPassword);

  String fireBaseProjectId;
  String fireBaseApiKey;
  String userEmail;
  String userPassword;

  bool areAllValuesNotNull() {
    return fireBaseProjectId != null &&
        fireBaseApiKey != null &&
        userEmail != null &&
        userPassword != null;
  }
}
