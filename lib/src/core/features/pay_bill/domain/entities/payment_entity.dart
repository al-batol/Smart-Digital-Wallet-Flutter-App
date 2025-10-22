import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final int billId;
  final String billType;
  final double amount;
  final String accountId;

  const PaymentEntity({
    required this.billId,
    required this.billType,
    required this.amount,
    required this.accountId,
  });

  @override
  List<Object?> get props => [billId, billType, amount, accountId];
}
