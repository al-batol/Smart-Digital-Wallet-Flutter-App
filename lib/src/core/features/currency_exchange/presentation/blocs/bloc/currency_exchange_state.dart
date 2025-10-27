part of 'currency_exchange_bloc.dart';

class CurrencyExchangeState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String errorMessage;
  final AccountEntity? fromAccount;
  final AccountEntity? toAccount;
  final int fromCurrencyIndex;
  final int toCurrencyIndex;
  final Success? exchangeResult;

  const CurrencyExchangeState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage = '',
    this.fromAccount,
    this.toAccount,
    this.fromCurrencyIndex = 0,
    this.toCurrencyIndex = 0,
    this.exchangeResult,
  });

  CurrencyExchangeState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    AccountEntity? fromAccount,
    AccountEntity? toAccount,
    int? fromCurrencyIndex,
    int? toCurrencyIndex,
    Success? exchangeResult,
  }) {
    return CurrencyExchangeState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
      fromAccount: fromAccount ?? this.fromAccount,
      toAccount: toAccount ?? this.toAccount,
      fromCurrencyIndex: fromCurrencyIndex ?? this.fromCurrencyIndex,
      toCurrencyIndex: toCurrencyIndex ?? this.toCurrencyIndex,
      exchangeResult: exchangeResult ?? this.exchangeResult,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    errorMessage,
    fromAccount,
    toAccount,
    fromCurrencyIndex,
    toCurrencyIndex,
    exchangeResult,
  ];
}
