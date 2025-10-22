import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/helper/format_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';

class AccountSelectorWidget extends StatelessWidget {
  final List<AccountEntity> accounts;
  final AccountEntity selectedAccount;

  const AccountSelectorWidget({
    super.key,
    required this.accounts,
    required this.selectedAccount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      buildWhen: (previous, current) =>
          previous.selectedAccount != current.selectedAccount,
      builder: (context, state) {
        final currentAccount = state.selectedAccount ?? selectedAccount;
        return DropdownSelectorWidget<AccountEntity>(
          title: 'Select Account',
          subtitle: 'Choose which account to send from',
          selectedValue: currentAccount,
          items: accounts,
          displayText: (account) =>
              FormatHelper.formatAccountDisplay(account.type.name, account.id),
          onChanged: (AccountEntity? newAccount) {
            if (newAccount != null) {
              context.read<SendMoneyBloc>().add(
                SelectAccountEvent(account: newAccount),
              );
            }
          },
        );
      },
    );
  }
}
