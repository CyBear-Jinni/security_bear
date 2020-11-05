import 'dart:async';
import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';

///  Network action class used for
///  controlling the program in the different network status
class NetworkActions {
  static String adminWiFiName;
  static String adminWiFiPass;
  static String wiFiName;
  static String wiFiPassword;

  NetworkActions(String adminWiFiNameF, String adminWiFiPassF, String wiFiNameF,
      String wiFiPasswordF) {
    adminWiFiName = adminWiFiNameF;
    adminWiFiPass = adminWiFiPassF;
    wiFiName = wiFiNameF;
    wiFiPassword = wiFiPasswordF;
  }

  ///  This function starts the connection to the requested WiFi
  ///  if the internet connection is down
  Future<bool> isConnectedToTheInternet() async {
    print('Status is ' + (await isConnectedToInternet()).toString());
    bool processLocation = false;
    //  true = Started the process to connect to the admin WiFi,
    //  false = waiting for the internet to go down

    Stream<DataConnectionStatus> listener = returnStatusIfChanged();

    listener.listen((status) async {
      bool isConnected = connectionStatusToBool(status);
      if (isConnected) {
        print('Connected to the Internet');
        processLocation = false;
      } else {
        print('Does not connected to the Internet');
        processLocation = true;
        await Future.delayed(
            const Duration(seconds: 15)); // Wait to check if internet is back

        // Continue only if internet is till off after timeout
        if (!processLocation) {
          return;
        }

        //  TODO: Get the available networks
        await getAvailableNetworksList();
        //  TODO: Keep until the admin wi-fi founded
        //  TODO: Check in between if connection returned with processLocation var
        //  TODO: Connect to admin wi-fi

        print('Finally');
      }
    });
  }

  ///  Check to see if admin wifi exist and try to connect to it
  Future<void> connectToAdminWhenExist() async {
    String connectedWifiName;
    while (true) {
      connectedWifiName = await getConnectedNetworkName();
      if (connectedWifiName != adminWiFiName &&
          (await getAvailableNetworksList()).contains(adminWiFiName)) {
        print('Connecting to admin wi-fi');
        await connectToAdminWiFi(ssid: adminWiFiName, pass: adminWiFiPass);
      }
      // If the device is not connected to any WiFi
      // will try reconnecting to the last network
      else if (connectedWifiName == null ||
          connectedWifiName == '' ||
          connectedWifiName != wiFiName &&
              (await getAvailableNetworksList()).contains(wiFiName)) {
        await connectToWiFi(wiFiName, wiFiPassword);
      }
      await Future.delayed(
          const Duration(seconds: 15)); // Wait to check if internet is back
    }
  }

  ///  This function check if there is WiFi with the name that it got,
  ///  if true it will try to connect to it with the password that it got
  Future<void> connectToAdminWiFi(
      {String ssid = 'ho', String pass = '123'}) async {
    String connectingResult = await connectToWiFi(ssid, pass);
    print('This is connection result: ' + connectingResult);
    // TODO: fix if connectingResult is 'Error: Connection activation failed: (60) New connection activation was enqueued.'
    // Need to delete it with 'nmcli con delete <SSID>' and than can connect again
  }

  ///  This function return the new value of the internet connection status
  ///  only if it changed from last time
  Stream<DataConnectionStatus> returnStatusIfChanged() {
    return DataConnectionChecker().onStatusChange;
  }


  Future<bool> isConnectedToInternet() async {
    return connectionStatusToBool(
        await DataConnectionChecker().connectionStatus);
  }

  ///  Convert connection status to true (connected) false (disconnected)
  bool connectionStatusToBool(DataConnectionStatus status) {
    switch (status) {
      case DataConnectionStatus.connected:
        return true;
      case DataConnectionStatus.disconnected:
        return false;
    }
    return false;
  }

  ///  Return list of available networks to the device
  Future<List<String>> getAvailableNetworksList() async {
//    Not Working with snap from apt
    return await Process.run('nmcli',
        ['-t', '-f', 'ssid', 'dev', 'wifi']).then((ProcessResult results) {
      //  nmcli -t -f ssid dev wifi
      List<String> wifi_results =
      results.stdout.toString().split('\n');
      wifi_results = wifi_results.sublist(0, wifi_results.length - 1);
      print(wifi_results.toString());
      return wifi_results;
    });
  }

  ///  Connect to the WiFi
  Future<String> connectToWiFi(String ssid, String pass) async {
//    Not Working with snap from apt
    return await Process.run('nmcli',
        ['dev', 'wifi', 'connect', ssid, 'password', pass]).then((
        // nmcli dev wifi connect ssid password pass
        //  sudo nmcli dev wifi connect ssid password pass
        ProcessResult results) {
      print('Conected successfully to: ' + results.stdout.toString());
      return results.stdout.toString();
    });
    //    Can iwconfig also be used but
    //    require root: iwconfig wlp3s0 essid ssid key pass
  }

  ///  Check if connected to network,
  ///  if there is a connection than return network name
  Future<String> getConnectedNetworkName() async {
    return await Process.run('iwgetid',
        ['-r']).then((ProcessResult results) {
      print('Currently connected to: ' + results.stdout.toString());
      return results.stdout.toString().replaceAll('\n', '');
    });

//    Not Working with snap from apt
//    return await Process.run('nmcli',
//        ['-t', '-f', 'ssid,In-USE', 'dev', 'wifi'
//        ]).then((ProcessResult results) {
//      print(results.stdout.toString());
//
//      return results.stdout.toString().replaceAll('\n', '');
//    });
  }
}