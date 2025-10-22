part of 'pay_bill_bloc.dart';

class PayBillState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final BillTypeEntity? selectedBillType;
  final Success? paymentResult;
  final bool isSuccess;

  const PayBillState({
    this.isLoading = false,
    this.errorMessage = '',
    this.selectedBillType,
    this.paymentResult,
    this.isSuccess = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    selectedBillType,
    paymentResult,
    isSuccess,
  ];

  PayBillState copyWith({
    bool? isLoading,
    String? errorMessage,
    BillTypeEntity? selectedBillType,
    Success? paymentResult,
    bool? isSuccess,
  }) {
    return PayBillState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedBillType: selectedBillType ?? this.selectedBillType,
      paymentResult: paymentResult ?? this.paymentResult,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
