part of 'top_up_bloc.dart';

sealed class TopUpEvent extends Equatable {
  const TopUpEvent();

  @override
  List<Object> get props => [];
}

class SelectAccountEvent extends TopUpEvent {
  final AccountEntity account;

  const SelectAccountEvent({required this.account});

  @override
  List<Object> get props => [account];
}

class SelectAmountEvent extends TopUpEvent {
  final double amount;

  const SelectAmountEvent({required this.amount});

  @override
  List<Object> get props => [amount];
}

class SelectCurrencyEvent extends TopUpEvent {
  final int currencyIndex;

  const SelectCurrencyEvent({required this.currencyIndex});

  @override
  List<Object> get props => [currencyIndex];
}

class ConfirmTopUpEvent extends TopUpEvent {
  final double amount;
  final String currency;
  final String accountId;

  const ConfirmTopUpEvent({
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object> get props => [amount, currency, accountId];
}
