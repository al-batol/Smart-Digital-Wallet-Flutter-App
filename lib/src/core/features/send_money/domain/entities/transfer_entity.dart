import 'package:equatable/equatable.dart';

class TransferEntity extends Equatable {
  final String recipientAccountId;
  final String sourceAccountId;
  final String currency;
  final double amount;

  const TransferEntity({
    required this.recipientAccountId,
    required this.sourceAccountId,
    required this.currency,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    recipientAccountId,
    sourceAccountId,
    currency,
    amount,
  ];
}
