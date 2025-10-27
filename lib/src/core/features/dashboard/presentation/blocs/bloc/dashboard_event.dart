part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class GetAccountsEvent extends DashboardEvent {
  const GetAccountsEvent();
}

class ToggleBalanceVisibilityEvent extends DashboardEvent {
  const ToggleBalanceVisibilityEvent();
}

class ToggleSelectedCurrencyEvent extends DashboardEvent {
  final int accountIndex;
  final int index;

  const ToggleSelectedCurrencyEvent({
    required this.index,
    required this.accountIndex,
  });

  @override
  List<Object> get props => [index];
}

class GetLastTransactionsEvent extends DashboardEvent {
  const GetLastTransactionsEvent();
}
