import 'package:equatable/equatable.dart';

class CurrencyExchangeEntity extends Equatable {
  final String fromAccountId;
  final String toAccountId;
  final String fromCurrency;
  final String toCurrency;
  final double amount;
  final double convertedAmount;
  final double exchangeRate;

  const CurrencyExchangeEntity({
    required this.fromAccountId,
    required this.toAccountId,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
    required this.convertedAmount,
    required this.exchangeRate,
  });

  @override
  List<Object?> get props => [
    fromAccountId,
    toAccountId,
    fromCurrency,
    toCurrency,
    amount,
    convertedAmount,
    exchangeRate,
  ];
}
