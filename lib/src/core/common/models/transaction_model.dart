import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends Equatable {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? type;
  @HiveField(2)
  final double? amount;
  @HiveField(3)
  final String? currency;
  @HiveField(4)
  final String? accountId;
  @HiveField(5)
  final String? recipientAccountId;
  @HiveField(6)
  final String? accountType;
  @HiveField(7)
  final String? billType;
  @HiveField(8)
  final String? number;
  @HiveField(9)
  final String? provider;
  @HiveField(10)
  @override
  final String? fromAccountId;

  @HiveField(11)
  @override
  final String? toAccountId;

  @HiveField(12)
  @override
  final String? fromCurrency;

  @HiveField(13)
  @override
  final String? toCurrency;

  @HiveField(14)
  @override
  final double? convertedAmount;

  @HiveField(15)
  @override
  final double? exchangeRate;

  const TransactionModel({
    this.id,
    this.type,
    this.amount,
    this.currency,
    this.accountId,
    this.recipientAccountId,
    this.accountType,
    this.billType,
    this.number,
    this.provider,
    this.fromAccountId,
    this.toAccountId,
    this.fromCurrency,
    this.toCurrency,
    this.convertedAmount,
    this.exchangeRate,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    amount,
    currency,
    accountId,
    recipientAccountId,
    accountType,
    billType,
    number,
    provider,
    fromAccountId,
    toAccountId,
    fromCurrency,
    toCurrency,
    convertedAmount,
    exchangeRate,
  ];

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      type: json['type'],
      amount: json['amount'],
      currency: json['currency'],
      accountId: json['accountId'],
      accountType: json['accountType'],
      billType: json['billType'],
      recipientAccountId: json['recipientAccountId'],
      number: json['number'],
      provider: json['provider'],
      fromAccountId: json['fromAccountId'],
      toAccountId: json['toAccountId'],
      fromCurrency: json['fromCurrency'],
      toCurrency: json['toCurrency'],
      convertedAmount: json['convertedAmount'],
      exchangeRate: json['exchangeRate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'currency': currency,
      'accountId': accountId,
      'accountType': accountType,
      'billType': billType,
      'recipientAccountId': recipientAccountId,
      'number': number,
      'provider': provider,
      'fromAccountId': fromAccountId,
      'toAccountId': toAccountId,
      'fromCurrency': fromCurrency,
      'toCurrency': toCurrency,
      'convertedAmount': convertedAmount,
      'exchangeRate': exchangeRate,
    };
  }
}
