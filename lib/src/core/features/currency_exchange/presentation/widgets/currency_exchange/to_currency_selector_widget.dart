import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/currency_balance_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/blocs/bloc/currency_exchange_bloc.dart';

class ToCurrencySelectorWidget extends StatelessWidget {
  final AccountEntity? selectedAccount;

  const ToCurrencySelectorWidget({super.key, required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    if (selectedAccount == null ||
        selectedAccount!.currencyBalances == null ||
        selectedAccount!.currencyBalances!.isEmpty) {
      return const SizedBox.shrink();
    }

    final currencies = selectedAccount!.currencyBalances!;

    return BlocBuilder<CurrencyExchangeBloc, CurrencyExchangeState>(
      buildWhen: (previous, current) =>
          previous.toCurrencyIndex != current.toCurrencyIndex,
      builder: (context, state) {
        final currentCurrency = currencies[state.toCurrencyIndex];
        return DropdownSelectorWidget<CurrencyBalanceEntity>(
          title: context.translate('to_currency'),
          subtitle: context.translate('choose_currency_to_exchange_to'),
          selectedValue: currentCurrency,
          items: currencies,
          displayText: (currency) =>
              '${currency.currency.currency} (${currency.balance})',
          onChanged: (CurrencyBalanceEntity? newCurrency) {
            if (newCurrency != null) {
              final index = currencies.indexOf(newCurrency);
              context.read<CurrencyExchangeBloc>().add(
                SelectToCurrencyEvent(currencyIndex: index),
              );
            }
          },
        );
      },
    );
  }
}
