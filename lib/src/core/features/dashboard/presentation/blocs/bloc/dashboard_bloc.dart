import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/accounts_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/currency_balance_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/get_accounts_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/usecases/get_last_transactions_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetAccountsUsecase getAccountsUsecase;
  final GetLastTransactionsUsecase getLastTransactionsUsecase;

  DashboardBloc({
    required this.getAccountsUsecase,
    required this.getLastTransactionsUsecase,
  }) : super(const DashboardState()) {
    on<GetAccountsEvent>(_onGetAccountsEventHandler);
    on<ToggleSelectedCurrencyEvent>(_onToggleSelectedCurrencyEventHandler);
    on<ToggleBalanceVisibilityEvent>(_onToggleBalanceVisibilityEventHandler);
    on<GetLastTransactionsEvent>(_onGetLastTransactionsEventHandler);
  }

  Future<void> _onGetAccountsEventHandler(
    GetAccountsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await getAccountsUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message, isLoading: false));
      },
      (user) {
        emit(
          state.copyWith(
            accounts: user,
            isLoading: false,
            errorMessage: '',
            selectedCurrency: user.accounts.first.currencyBalances?.first,
          ),
        );
      },
    );
  }

  void _onToggleSelectedCurrencyEventHandler(
    ToggleSelectedCurrencyEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedCurrencyIndex: event.index));
  }

  void _onToggleBalanceVisibilityEventHandler(
    ToggleBalanceVisibilityEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(isBalanceVisible: !state.isBalanceVisible));
  }

  Future<void> _onGetLastTransactionsEventHandler(
    GetLastTransactionsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final result = await getLastTransactionsUsecase();
    result.fold((failure) {}, (transactions) {
      emit(state.copyWith(lastTransactions: transactions));
    });
  }
}
