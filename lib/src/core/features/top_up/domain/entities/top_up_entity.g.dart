// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopUpEntityAdapter extends TypeAdapter<TopUpEntity> {
  @override
  final int typeId = 1;

  @override
  TopUpEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopUpEntity(
      amount: fields[2] as double?,
      currency: fields[3] as String?,
      accountId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TopUpEntity obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.accountId)
      ..writeByte(5)
      ..write(obj.recipientAccountId)
      ..writeByte(6)
      ..write(obj.accountType)
      ..writeByte(7)
      ..write(obj.billType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopUpEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
