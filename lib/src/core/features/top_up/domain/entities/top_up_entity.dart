import 'package:equatable/equatable.dart';

class TopUpEntity extends Equatable {
  final double amount;
  final String currency;
  final String accountId;

  const TopUpEntity({
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object?> get props => [amount, currency, accountId];
}
