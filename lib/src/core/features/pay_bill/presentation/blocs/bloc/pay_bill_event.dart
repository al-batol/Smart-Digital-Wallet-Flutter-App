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
  final int billId;
  final String billType;
  final double amount;
  final String accountId;

  const ConfirmPayBillEvent({
    required this.billId,
    required this.billType,
    required this.amount,
    required this.accountId,
  });

  @override
  List<Object> get props => [billId, billType, amount, accountId];
}
