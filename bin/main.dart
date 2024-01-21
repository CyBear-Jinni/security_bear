import 'package:cbj_integrations_controller/integrations_controller.dart';
import 'package:security_bear/domain/local_db/i_local_db_repository.dart';
import 'package:security_bear/features/security_bear/application/usecases/core_u/security_bear_manager.dart';
import 'package:security_bear/injection.dart';
import 'package:security_bear/utils.dart';

void main(List<String> arguments) async {
  configureInjection(Env.prod);

  if (arguments.isEmpty) {
    SharedVariables().asyncConstructor('.');
  } else {
    SharedVariables().asyncConstructor(arguments[0]);
  }
  //  Setting device model and checking if configuration for this model exist
  await DevicePinListManager().setPhysicalDeviceType();
  getIt<ILocalDbRepository>();
  logger.t('');

  SecurityBearManagerU();
}
