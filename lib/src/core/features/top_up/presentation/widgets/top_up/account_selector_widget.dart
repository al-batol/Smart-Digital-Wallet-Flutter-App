import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
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

  String _formatAccountDisplay(AccountEntity account) {
    final accountType =
        account.type.name[0].toUpperCase() + account.type.name.substring(1);
    final idParts = account.id.split(',');
    final lastFourDigits = idParts.last;
    return '$accountType (**** $lastFourDigits)';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidgetMd(
          text: 'Select Account',
          textColor: textHeadlineColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        const TextWidgetSm(
          text: 'Choose which account to add money',
          textColor: textSecondaryColor,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        BlocBuilder<TopUpBloc, TopUpState>(
          buildWhen: (previous, current) =>
              previous.selectedAccount != current.selectedAccount,
          builder: (context, state) {
            final currentAccount = state.selectedAccount ?? selectedAccount;
            return DropdownButtonFormField<AccountEntity>(
              initialValue: currentAccount,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textHeadlineColor.withValues(alpha: 0.2),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textHeadlineColor.withValues(alpha: 0.2),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: textHeadlineColor.withValues(alpha: 0.2),
                  ),
                ),
                contentPadding: EdgeInsets.all(
                  AppDimensions.paddingSm.width(context),
                ),
              ),
              items: accounts.map((account) {
                return DropdownMenuItem<AccountEntity>(
                  value: account,
                  child: TextWidgetMd(
                    text: _formatAccountDisplay(account),
                    textColor: textMainColor,
                  ),
                );
              }).toList(),
              onChanged: (AccountEntity? newAccount) {
                if (newAccount != null) {
                  context.read<TopUpBloc>().add(
                    SelectAccountEvent(account: newAccount),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
