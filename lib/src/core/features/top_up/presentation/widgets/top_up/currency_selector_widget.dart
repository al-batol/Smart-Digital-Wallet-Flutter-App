import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/chip_widget.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';

class CurrencySelectorWidget extends StatelessWidget {
  final AccountEntity? selectedAccount;

  const CurrencySelectorWidget({super.key, required this.selectedAccount});

  @override
  Widget build(BuildContext context) {
    if (selectedAccount == null || selectedAccount!.currencyBalances == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidgetMd(
          text: context.translate(selectCurrency),
          textColor: textHeadlineColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        TextWidgetSm(
          text: context.translate(chooseCurrencyToTopUp),
          textColor: textSecondaryColor,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        BlocBuilder<TopUpBloc, TopUpState>(
          buildWhen: (previous, current) =>
              previous.selectedCurrencyIndex != current.selectedCurrencyIndex ||
              previous.selectedAccount != current.selectedAccount,
          builder: (context, state) {
            return Wrap(
              spacing: AppDimensions.spacingSm.width(context),
              runSpacing: AppDimensions.spacingSm.height(context),
              children: selectedAccount!.currencyBalances!
                  .asMap()
                  .entries
                  .map(
                    (entry) => ChipWidget(
                      currency: entry.value.currency.currency,
                      isSelected: state.selectedCurrencyIndex == entry.key,
                      onTap: () {
                        context.read<TopUpBloc>().add(
                          SelectCurrencyEvent(currencyIndex: entry.key),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
