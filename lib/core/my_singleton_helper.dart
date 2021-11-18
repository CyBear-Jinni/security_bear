import 'package:security_bear_dart/core/system_commands_d/system_commands_manager_d.dart';

class MySingletonHelper {
  static Future<String> getUuid() {
    final SystemCommandsManager systemCommandsManager = SystemCommandsManager();
    return systemCommandsManager.getUuidOfCurrentDevice();
  }

  static Future<String> getCurrentUserName() {
    final SystemCommandsManager systemCommandsManager = SystemCommandsManager();
    return systemCommandsManager.getCurrentUserName();
  }
}
