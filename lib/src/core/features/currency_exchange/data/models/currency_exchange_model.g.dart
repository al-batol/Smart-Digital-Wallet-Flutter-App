// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_exchange_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyExchangeModelAdapter extends TypeAdapter<CurrencyExchangeModel> {
  @override
  final int typeId = 4;

  @override
  CurrencyExchangeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyExchangeModel(
      fromAccountId: fields[10] as String?,
      toAccountId: fields[11] as String?,
      fromCurrency: fields[12] as String?,
      toCurrency: fields[13] as String?,
      amount: fields[2] as double?,
      convertedAmount: fields[14] as double?,
      exchangeRate: fields[15] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyExchangeModel obj) {
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
      other is CurrencyExchangeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
