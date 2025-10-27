import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/helper/format_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/blocs/bloc/currency_exchange_bloc.dart';

class ToAccountSelectorWidget extends StatelessWidget {
  final List<AccountEntity> accounts;
  final AccountEntity selectedAccount;

  const ToAccountSelectorWidget({
    super.key,
    required this.accounts,
    required this.selectedAccount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyExchangeBloc, CurrencyExchangeState>(
      buildWhen: (previous, current) => previous.toAccount != current.toAccount,
      builder: (context, state) {
        final currentAccount = state.toAccount ?? selectedAccount;
        return DropdownSelectorWidget<AccountEntity>(
          title: context.translate('to_account'),
          subtitle: context.translate('choose_account_to_exchange_to'),
          selectedValue: currentAccount,
          items: accounts,
          displayText: (account) =>
              FormatHelper.formatAccountDisplay(account.type.name, account.id),
          onChanged: (AccountEntity? newAccount) {
            if (newAccount != null) {
              context.read<CurrencyExchangeBloc>().add(
                SelectToAccountEvent(account: newAccount),
              );
            }
          },
        );
      },
    );
  }
}
