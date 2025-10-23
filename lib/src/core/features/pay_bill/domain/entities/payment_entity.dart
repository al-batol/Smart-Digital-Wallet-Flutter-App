import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String billType;
  final String billNumber;
  final double amount;
  final String currency;
  final String accountId;

  const PaymentEntity({
    required this.billType,
    required this.billNumber,
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object?> get props => [
    billType,
    billNumber,
    amount,
    currency,
    accountId,
  ];
}
