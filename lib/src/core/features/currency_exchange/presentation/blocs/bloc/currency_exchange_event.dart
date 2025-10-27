part of 'currency_exchange_bloc.dart';

sealed class CurrencyExchangeEvent extends Equatable {
  const CurrencyExchangeEvent();

  @override
  List<Object?> get props => [];
}

class SelectFromAccountEvent extends CurrencyExchangeEvent {
  final AccountEntity account;

  const SelectFromAccountEvent({required this.account});

  @override
  List<Object?> get props => [account];
}

class SelectToAccountEvent extends CurrencyExchangeEvent {
  final AccountEntity account;

  const SelectToAccountEvent({required this.account});

  @override
  List<Object?> get props => [account];
}

class SelectFromCurrencyEvent extends CurrencyExchangeEvent {
  final int currencyIndex;

  const SelectFromCurrencyEvent({required this.currencyIndex});

  @override
  List<Object?> get props => [currencyIndex];
}

class SelectToCurrencyEvent extends CurrencyExchangeEvent {
  final int currencyIndex;

  const SelectToCurrencyEvent({required this.currencyIndex});

  @override
  List<Object?> get props => [currencyIndex];
}

class ConfirmExchangeEvent extends CurrencyExchangeEvent {
  final String fromAccountId;
  final String toAccountId;
  final String fromCurrency;
  final String toCurrency;
  final double amount;

  const ConfirmExchangeEvent({
    required this.fromAccountId,
    required this.toAccountId,
    required this.fromCurrency,
    required this.toCurrency,
    required this.amount,
  });

  @override
  List<Object?> get props => [
    fromAccountId,
    toAccountId,
    fromCurrency,
    toCurrency,
    amount,
  ];
}
