part of 'pay_bill_bloc.dart';

sealed class PayBillEvent extends Equatable {
  const PayBillEvent();

  @override
  List<Object> get props => [];
}

class SelectBillTypeEvent extends PayBillEvent {
  final BillTypeEntity billType;

  const SelectBillTypeEvent({required this.billType});

  @override
  List<Object> get props => [billType];
}

class ConfirmPayBillEvent extends PayBillEvent {
  final String billType;
  final String billNumber;
  final double amount;
  final String currency;
  final String accountId;

  const ConfirmPayBillEvent({
    required this.billType,
    required this.billNumber,
    required this.amount,
    required this.currency,
    required this.accountId,
  });

  @override
  List<Object> get props => [billType, billNumber, amount, currency, accountId];
}
