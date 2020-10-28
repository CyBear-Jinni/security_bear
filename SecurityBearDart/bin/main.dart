import 'package:SecurityBearDart/director.dart';

main(List<String> arguments) async {
  print("helllow");

  String snapPath;

  if (arguments.length < 1) {
    snapPath = '.';
  } else {
    snapPath = arguments[0];
  }
  Director director = Director(snapPath);
}
