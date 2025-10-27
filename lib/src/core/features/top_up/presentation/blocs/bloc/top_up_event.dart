part of 'top_up_bloc.dart';

sealed class TopUpEvent extends Equatable {
  const TopUpEvent();

  @override
  List<Object> get props => [];
}

class SelectProviderEvent extends TopUpEvent {
  final ProviderEntity provider;

  const SelectProviderEvent({required this.provider});

  @override
  List<Object> get props => [provider];
}

class ConfirmTopUpEvent extends TopUpEvent {
  final String provider;
  final String number;
  final double amount;
  final String currency;
  final String accountId;

  const ConfirmTopUpEvent({
    required this.provider,
    required this.number,
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object> get props => [provider, number, amount, currency, accountId];
}
