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
    };
  }
}
