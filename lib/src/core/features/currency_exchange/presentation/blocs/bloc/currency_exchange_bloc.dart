import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/entities/currency_exchange_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/usecases/currency_exchange_usecase.dart';

part 'currency_exchange_event.dart';
part 'currency_exchange_state.dart';

class CurrencyExchangeBloc
    extends Bloc<CurrencyExchangeEvent, CurrencyExchangeState> {
  final CurrencyExchangeUsecase currencyExchangeUsecase;

  CurrencyExchangeBloc({required this.currencyExchangeUsecase})
    : super(const CurrencyExchangeState()) {
    on<SelectFromAccountEvent>(_onSelectFromAccountEventHandler);
    on<SelectToAccountEvent>(_onSelectToAccountEventHandler);
    on<SelectFromCurrencyEvent>(_onSelectFromCurrencyEventHandler);
    on<SelectToCurrencyEvent>(_onSelectToCurrencyEventHandler);
    on<ConfirmExchangeEvent>(_onConfirmExchangeEventHandler);
  }

  void _onSelectFromAccountEventHandler(
    SelectFromAccountEvent event,
    Emitter<CurrencyExchangeState> emit,
  ) {
    emit(state.copyWith(fromAccount: event.account, fromCurrencyIndex: 0));
  }

  void _onSelectToAccountEventHandler(
    SelectToAccountEvent event,
    Emitter<CurrencyExchangeState> emit,
  ) {
    emit(state.copyWith(toAccount: event.account, toCurrencyIndex: 0));
  }

  void _onSelectFromCurrencyEventHandler(
    SelectFromCurrencyEvent event,
    Emitter<CurrencyExchangeState> emit,
  ) {
    emit(state.copyWith(fromCurrencyIndex: event.currencyIndex));
  }

  void _onSelectToCurrencyEventHandler(
    SelectToCurrencyEvent event,
    Emitter<CurrencyExchangeState> emit,
  ) {
    emit(state.copyWith(toCurrencyIndex: event.currencyIndex));
  }

  Future<void> _onConfirmExchangeEventHandler(
    ConfirmExchangeEvent event,
    Emitter<CurrencyExchangeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', isSuccess: false));

    // Calculate exchange rate and converted amount
    final exchangeRate = _getExchangeRate(event.fromCurrency, event.toCurrency);

    if (exchangeRate == 0.0) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: 'exchange_not_allowed',
        ),
      );
      return;
    }

    final convertedAmount = event.amount * exchangeRate;

    final exchange = CurrencyExchangeEntity(
      fromAccountId: event.fromAccountId,
      toAccountId: event.toAccountId,
      fromCurrency: event.fromCurrency,
      toCurrency: event.toCurrency,
      amount: event.amount,
      convertedAmount: convertedAmount,
      exchangeRate: exchangeRate,
    );

    final result = await currencyExchangeUsecase(exchange);

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ),
      ),
      (success) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          exchangeResult: success,
          errorMessage: '',
        ),
      ),
    );
  }

  // Exchange rate calculation based on user requirements:
  // USD to YER: 1 USD = 530 YER
  // YER to USD: 1 YER = 1/530 USD
  // SAR to YER: 1 SAR = 140 YER
  // YER to SAR: 1 YER = 1/140 SAR
  // USD to SAR: NOT ALLOWED
  // SAR to USD: NOT ALLOWED
  double _getExchangeRate(String fromCurrency, String toCurrency) {
    if (fromCurrency == toCurrency) {
      return 1.0;
    }

    // USD to YER
    if (fromCurrency == AccountCurrency.usd.currency &&
        toCurrency == AccountCurrency.yer.currency) {
      return 530.0;
    }

    // YER to USD
    if (fromCurrency == AccountCurrency.yer.currency &&
        toCurrency == AccountCurrency.usd.currency) {
      return 1.0 / 530.0;
    }

    // SAR to YER
    if (fromCurrency == AccountCurrency.sar.currency &&
        toCurrency == AccountCurrency.yer.currency) {
      return 140.0;
    }

    // YER to SAR
    if (fromCurrency == AccountCurrency.yer.currency &&
        toCurrency == AccountCurrency.sar.currency) {
      return 1.0 / 140.0;
    }

    // USD to SAR or SAR to USD - NOT ALLOWED
    if ((fromCurrency == AccountCurrency.usd.currency &&
            toCurrency == AccountCurrency.sar.currency) ||
        (fromCurrency == AccountCurrency.sar.currency &&
            toCurrency == AccountCurrency.usd.currency)) {
      return 0.0; // Not allowed
    }

    return 0.0; // Default: not allowed
  }
}
