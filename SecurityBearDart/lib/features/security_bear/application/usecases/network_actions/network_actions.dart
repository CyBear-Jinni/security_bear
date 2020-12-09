import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:security_bear_dart/data_base/cbj_app/cbj_app_client.dart';
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
      else if (connectedWifiName == adminWiFiName){
        String wiFiDeafultGateway = await getDefaultGateway();

        String myDeviceIP = await getCurrentDeviceIP(currentDefaultGateWay: wiFiDeafultGateway);

        bool successful = await CBJAppClient.SendMyIPToServer(wiFiDeafultGateway, myDeviceIP);

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
    return Process.run('nmcli',
        <String>['-t', '-f', 'ssid', 'dev', 'wifi']).then((ProcessResult results) {
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
    return Process.run('nmcli',
        <String>['dev', 'wifi', 'connect', ssid, 'password', pass]).then((
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
    return Process.run('iwgetid',
        <String>['-r']).then((ProcessResult results) {
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

  /// Getting the current device ip
  Future<String> getCurrentDeviceIP({String currentDefaultGateWay}) async {
    String currentIP = await Process.run('hostname',
        <String>['-I']).then((ProcessResult results) {
      return results.stdout.toString().replaceAll('\n', '');
    });


    if(currentIP.isNotEmpty && currentIP.contains(' ')){
      List<String> currentIPList = currentIP.split(' ');
      currentIPList.removeWhere((String element) => element == '');
      
      if(currentDefaultGateWay.isNotEmpty){
        String currentDefaultGateWayWithoutLastNumbers = ipWithoutLastNumbers(currentDefaultGateWay);

        for (String ipFromScan in currentIPList){
          String ipFromScanWithoutLastNumbers = ipWithoutLastNumbers(ipFromScan);

          if(ipFromScanWithoutLastNumbers == currentDefaultGateWayWithoutLastNumbers){
            return ipFromScan;
          }
        }
      }
      else {
        currentIP = currentIPList[Random().nextInt(currentIPList.length)];
      }
    }
    print('Device IP is: ' + currentIP!= null ? currentIP: 'NULL');
    return currentIP;
  }

  /// Getting the default gateway of connected network
  Future<String> getDefaultGateway({String currentIP}) async {
    String defaultGateway = await Process.run('ip',
        <String>['route']).then((ProcessResult results) {
      return results.stdout.toString();
    });


    List<String> gatewayLinesWithDefault = [];

    List<String> gatewayTemp = defaultGateway.split('\n');
    gatewayTemp.removeWhere((String element) => element == '');

    if(gatewayTemp.isEmpty){
      return null;
    }

    for(String gatewayLine in gatewayTemp){
      if(gatewayLine.contains('default')){
        gatewayLinesWithDefault.add(gatewayLine);
      }
    }

    String gateway;
    if(gatewayLinesWithDefault.length > 1){
      if(currentIP.isNotEmpty){
        for(final String gatewayLine in gatewayLinesWithDefault){
          final String currentIPWithoutLastNumber = ipWithoutLastNumbers(currentIP);
          if(gatewayLine.contains(currentIPWithoutLastNumber)){
            return extractIpFromLine(gatewayLine);
          }
        }
        return gateway;
      }
      defaultGateway = gatewayLinesWithDefault[Random().nextInt(gatewayLinesWithDefault.length)];
    }
    else {
      defaultGateway = gatewayLinesWithDefault[0];
    }


    if(defaultGateway.isEmpty) {
      return null;
    }

    return extractIpFromLine(defaultGateway);
  }

  /// Getting string with IP and returning only the IP
  String extractIpFromLine(String iPWithLine){
    final RegExp firstNumberRegExp = RegExp('[0-9]+');
    final int ipIndex = iPWithLine.indexOf(firstNumberRegExp);
    if(ipIndex < 0){
      return null;
    }

    String ip = iPWithLine.substring(ipIndex);
    ip = ip.substring(0, ip.indexOf(' '));
    return ip;
  }
  
  /// Retrieving the ip without the number after the last dot
  String ipWithoutLastNumbers(String ip){
    return ip.substring(0, ip.lastIndexOf('.'));
  }
}