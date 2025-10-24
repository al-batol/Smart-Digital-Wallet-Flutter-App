import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/helper/format_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';

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
    return BlocBuilder<TopUpBloc, TopUpState>(
      buildWhen: (previous, current) =>
          previous.selectedAccount != current.selectedAccount,
      builder: (context, state) {
        final currentAccount = state.selectedAccount ?? selectedAccount;
        return DropdownSelectorWidget<AccountEntity>(
          title: context.translate(selectAccount),
          subtitle: context.translate(chooseAccountToAddMoney),
          selectedValue: currentAccount,
          items: accounts,
          displayText: (account) =>
              FormatHelper.formatAccountDisplay(account.type.name, account.id),
          onChanged: (AccountEntity? newAccount) {
            if (newAccount != null) {
              context.read<TopUpBloc>().add(
                SelectAccountEvent(account: newAccount),
              );
            }
          },
        );
      },
    );
  }
}
