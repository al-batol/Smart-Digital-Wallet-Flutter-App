import 'package:equatable/equatable.dart';

class TopUpEntity extends Equatable {
  final String provider;
  final String number;
  final double amount;
  final String currency;
  final String accountId;

  const TopUpEntity({
    required this.provider,
    required this.number,
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object?> get props => [provider, number, amount, currency, accountId];
}
