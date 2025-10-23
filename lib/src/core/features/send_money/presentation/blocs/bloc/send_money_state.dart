part of 'send_money_bloc.dart';

class SendMoneyState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final AccountEntity? selectedAccount;
  final BeneficiaryEntity? selectedBeneficiary;
  final int selectedCurrencyIndex;
  final List<BeneficiaryEntity> beneficiaries;
  final Success? sendMoneyResult;
  final bool isSuccess;
  final bool useBeneficiary;

  const SendMoneyState({
    this.isLoading = false,
    this.errorMessage = '',
    this.selectedAccount,
    this.selectedBeneficiary,
    this.selectedCurrencyIndex = 0,
    this.beneficiaries = const [],
    this.sendMoneyResult,
    this.isSuccess = false,
    this.useBeneficiary = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    selectedAccount,
    selectedBeneficiary,
    selectedCurrencyIndex,
    beneficiaries,
    sendMoneyResult,
    isSuccess,
    useBeneficiary,
  ];

  SendMoneyState copyWith({
    bool? isLoading,
    String? errorMessage,
    AccountEntity? selectedAccount,
    BeneficiaryEntity? selectedBeneficiary,
    int? selectedCurrencyIndex,
    List<BeneficiaryEntity>? beneficiaries,
    Success? sendMoneyResult,
    bool? isSuccess,
    bool? useBeneficiary,
  }) {
    return SendMoneyState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAccount: selectedAccount ?? this.selectedAccount,
      selectedBeneficiary: selectedBeneficiary ?? this.selectedBeneficiary,
      selectedCurrencyIndex:
          selectedCurrencyIndex ?? this.selectedCurrencyIndex,
      beneficiaries: beneficiaries ?? this.beneficiaries,
      sendMoneyResult: sendMoneyResult ?? this.sendMoneyResult,
      isSuccess: isSuccess ?? this.isSuccess,
      useBeneficiary: useBeneficiary ?? this.useBeneficiary,
    );
  }
}
