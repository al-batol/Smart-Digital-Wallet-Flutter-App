part of 'send_money_bloc.dart';

sealed class SendMoneyEvent extends Equatable {
  const SendMoneyEvent();

  @override
  List<Object> get props => [];
}

class GetBeneficiariesEvent extends SendMoneyEvent {
  const GetBeneficiariesEvent();
}

class SelectAccountEvent extends SendMoneyEvent {
  final AccountEntity account;

  const SelectAccountEvent({required this.account});

  @override
  List<Object> get props => [account];
}

class SelectBeneficiaryEvent extends SendMoneyEvent {
  final BeneficiaryEntity beneficiary;

  const SelectBeneficiaryEvent({required this.beneficiary});

  @override
  List<Object> get props => [beneficiary];
}

class SelectCurrencyEvent extends SendMoneyEvent {
  final int currencyIndex;

  const SelectCurrencyEvent({required this.currencyIndex});

  @override
  List<Object> get props => [currencyIndex];
}

class ToggleRecipientModeEvent extends SendMoneyEvent {
  final bool useBeneficiary;

  const ToggleRecipientModeEvent({required this.useBeneficiary});

  @override
  List<Object> get props => [useBeneficiary];
}

class ConfirmSendMoneyEvent extends SendMoneyEvent {
  final String recipientAccountId;
  final String sourceAccountId;
  final String currency;
  final double amount;

  const ConfirmSendMoneyEvent({
    required this.recipientAccountId,
    required this.sourceAccountId,
    required this.currency,
    required this.amount,
  });

  @override
  List<Object> get props => [
    recipientAccountId,
    sourceAccountId,
    currency,
    amount,
  ];
}
