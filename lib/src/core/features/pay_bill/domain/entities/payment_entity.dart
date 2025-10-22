import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String billType;
  final double amount;
  final String currency;
  final String accountId;

  const PaymentEntity({
    required this.billType,
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object?> get props => [billType, amount, currency, accountId];
}
