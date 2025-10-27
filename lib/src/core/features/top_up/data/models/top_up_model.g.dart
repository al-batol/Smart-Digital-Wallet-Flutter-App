// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_up_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopUpModelAdapter extends TypeAdapter<TopUpModel> {
  @override
  final int typeId = 1;

  @override
  TopUpModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopUpModel(
      provider: fields[9] as String?,
      number: fields[8] as String?,
      amount: fields[2] as double?,
      currency: fields[3] as String?,
      accountId: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TopUpModel obj) {
    writer
      ..writeByte(16)
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
      ..write(obj.billType)
      ..writeByte(8)
      ..write(obj.number)
      ..writeByte(9)
      ..write(obj.provider)
      ..writeByte(10)
      ..write(obj.fromAccountId)
      ..writeByte(11)
      ..write(obj.toAccountId)
      ..writeByte(12)
      ..write(obj.fromCurrency)
      ..writeByte(13)
      ..write(obj.toCurrency)
      ..writeByte(14)
      ..write(obj.convertedAmount)
      ..writeByte(15)
      ..write(obj.exchangeRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopUpModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
