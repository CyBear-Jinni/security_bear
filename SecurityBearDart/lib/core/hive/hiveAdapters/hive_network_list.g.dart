// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_network_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveNetwokListAdapter extends TypeAdapter<HiveNetworkList> {
  @override
  final int typeId = 1;

  @override
  HiveNetworkList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveNetworkList()
      ..networksInfoList = (fields[0] as List)?.cast<NetworkEntity>();
  }

  @override
  void write(BinaryWriter writer, HiveNetworkList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.networksInfoList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveNetwokListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
