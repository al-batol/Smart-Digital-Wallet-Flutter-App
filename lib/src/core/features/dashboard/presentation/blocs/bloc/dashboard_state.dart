part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final bool isBalanceVisible;
  final String errorMessage;
  final AccountsEntity? accounts;
  final int selectedCurrencyIndex;

  const DashboardState({
    this.isLoading = false,
    this.isBalanceVisible = false,
    this.errorMessage = '',
    this.accounts,
    this.selectedCurrencyIndex = 0,
  });

  DashboardState copyWith({
    bool? isLoading,
    bool? isBalanceVisible,
    String? errorMessage,
    AccountsEntity? accounts,
    CurrencyBalanceEntity? selectedCurrency,
    int? selectedCurrencyIndex,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
      errorMessage: errorMessage ?? this.errorMessage,
      accounts: accounts ?? this.accounts,
      selectedCurrencyIndex:
          selectedCurrencyIndex ?? this.selectedCurrencyIndex,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isBalanceVisible,
    errorMessage,
    accounts,
    selectedCurrencyIndex,
  ];
}
