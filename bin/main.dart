import 'package:security_bear_dart/domain/local_db/i_local_db_repository.dart';
import 'package:security_bear_dart/features/security_bear/application/usecases/core_u/security_bear_manager.dart';
import 'package:security_bear_dart/infrastructure/core/shared_variables.dart';
import 'package:security_bear_dart/infrastructure/system_commands/device_pin_manager.dart';
import 'package:security_bear_dart/injection.dart';
import 'package:security_bear_dart/utils.dart';

main(List<String> arguments) async {
  await configureInjection(Env.prod);

  logger.w('Welcome to Security Bear');

  if (arguments.isEmpty) {
    SharedVariables('.');
  } else {
    SharedVariables(arguments[0]);
  }
  //  Setting device model and checking if configuration for this model exist
  await DevicePinListManager().setPhysicalDeviceType();
  getIt<ILocalDbRepository>();
  logger.v('');

  SecurityBearManagerU();
}
