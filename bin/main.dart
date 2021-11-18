import 'package:security_bear_dart/core/shared_variables.dart';
import 'package:security_bear_dart/features/security_bear/application/usecases/core_u/security_bear_manager.dart';

main(List<String> arguments) async {
  print('Welcome to Security Bear');

  if (arguments.isEmpty) {
    SharedVariables('.');
  } else {
    SharedVariables(arguments[0]);
  }

  SecurityBearManagerU();
}
