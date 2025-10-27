import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/entities/currency_exchange_entity.dart';

part 'currency_exchange_model.g.dart';

@HiveType(typeId: 4)
class CurrencyExchangeModel extends TransactionModel {
  const CurrencyExchangeModel({
    required super.fromAccountId,
    required super.toAccountId,
    required super.fromCurrency,
    required super.toCurrency,
    required super.amount,
    required super.convertedAmount,
    required super.exchangeRate,
  }) : super(type: "exchangeCurrency");

  factory CurrencyExchangeModel.fromJson(Map<String, dynamic> json) {
    return CurrencyExchangeModel(
      fromAccountId: json['fromAccountId'] as String,
      toAccountId: json['toAccountId'] as String,
      fromCurrency: json['fromCurrency'] as String,
      toCurrency: json['toCurrency'] as String,
      amount: (json['amount'] as num).toDouble(),
      convertedAmount: (json['convertedAmount'] as num).toDouble(),
      exchangeRate: (json['exchangeRate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromAccountId': fromAccountId,
      'toAccountId': toAccountId,
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'amount': amount,
      'convertedAmount': convertedAmount,
      'exchangeRate': exchangeRate,
    };
  }

  factory CurrencyExchangeModel.fromEntity(CurrencyExchangeEntity entity) {
    return CurrencyExchangeModel(
      fromAccountId: entity.fromAccountId,
      toAccountId: entity.toAccountId,
      fromCurrency: entity.fromCurrency,
      toCurrency: entity.toCurrency,
      amount: entity.amount,
      convertedAmount: entity.convertedAmount,
      exchangeRate: entity.exchangeRate,
    );
  }

  CurrencyExchangeEntity toEntity() {
    return CurrencyExchangeEntity(
      fromAccountId: fromAccountId ?? '',
      toAccountId: toAccountId ?? '',
      fromCurrency: fromCurrency ?? '',
      toCurrency: toCurrency ?? '',
      amount: amount ?? 0,
      convertedAmount: convertedAmount ?? 0,
      exchangeRate: exchangeRate ?? 0,
    );
  }
}
