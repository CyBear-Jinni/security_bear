import 'package:hive/hive.dart';
import 'package:security_bear_dart/features/security_bear/infrastructure/core/NetworkEntity.dart';

part 'hive_network_list.g.dart';

@HiveType(typeId: 1)
class HiveNetworkList {
  @HiveField(0)
  List<NetworkEntity> networksInfoList;
}
