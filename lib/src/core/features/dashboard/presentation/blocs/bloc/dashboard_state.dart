part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final bool isBalanceVisible;
  final String errorMessage;
  final AccountsEntity? accounts;
  final List<int?>? selectedCurrencyIndexes;
  final List<TransactionModel> lastTransactions;

  const DashboardState({
    this.isLoading = false,
    this.isBalanceVisible = false,
    this.errorMessage = '',
    this.accounts,
    this.selectedCurrencyIndexes,
    this.lastTransactions = const [],
  });

  DashboardState copyWith({
    bool? isLoading,
    bool? isBalanceVisible,
    String? errorMessage,
    AccountsEntity? accounts,
    CurrencyBalanceEntity? selectedCurrency,
    List<int>? selectedCurrencyIndexes,
    List<TransactionModel>? lastTransactions,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isBalanceVisible: isBalanceVisible ?? this.isBalanceVisible,
      errorMessage: errorMessage ?? this.errorMessage,
      accounts: accounts ?? this.accounts,
      selectedCurrencyIndexes:
          selectedCurrencyIndexes ?? this.selectedCurrencyIndexes,
      lastTransactions: lastTransactions ?? this.lastTransactions,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isBalanceVisible,
    errorMessage,
    accounts,
    selectedCurrencyIndexes,
    lastTransactions,
  ];
}
