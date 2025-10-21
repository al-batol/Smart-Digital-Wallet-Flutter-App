part of 'top_up_bloc.dart';

class TopUpState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final double? selectedAmount;
  final AccountEntity? selectedAccount;
  final int selectedCurrencyIndex;
  final Success? topUpResult;
  final bool isSuccess;

  const TopUpState({
    this.isLoading = false,
    this.errorMessage = '',
    this.selectedAmount,
    this.selectedAccount,
    this.selectedCurrencyIndex = 0,
    this.topUpResult,
    this.isSuccess = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    selectedAmount,
    selectedAccount,
    selectedCurrencyIndex,
    topUpResult,
    isSuccess,
  ];

  TopUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    double? selectedAmount,
    AccountEntity? selectedAccount,
    int? selectedCurrencyIndex,
    Success? topUpResult,
    bool? isSuccess,
  }) {
    return TopUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAmount: selectedAmount ?? this.selectedAmount,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedCurrencyIndex:
          selectedCurrencyIndex ?? this.selectedCurrencyIndex,
      topUpResult: topUpResult ?? this.topUpResult,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
