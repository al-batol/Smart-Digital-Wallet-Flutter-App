import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart'
    as colors;
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/transaction_item_widget.dart';

class TransactionsListWidget extends StatelessWidget {
  const TransactionsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      buildWhen: (previous, current) =>
          previous.lastTransactions != current.lastTransactions,
      builder: (context, state) {
        if (state.lastTransactions.isEmpty) {
          return Container(
            padding: EdgeInsets.all(AppDimensions.spacingMd.width(context)),
            decoration: BoxDecoration(
              color: colors.softLightColor,
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMd.toDouble(),
              ),
            ),
            child: Center(
              child: TextWidgetSm(
                text: 'No transactions yet',
                textColor: colors.textSecondaryColor,
              ),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidgetMd(
              text: 'Last Transactions',
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: AppDimensions.spacingMd.height(context)),
            ...state.lastTransactions
                .map(
                  (transaction) =>
                      TransactionItemWidget(transaction: transaction),
                )
                .toList(),
            SizedBox(height: AppDimensions.spacingLg.height(context)),
          ],
        );
      },
    );
  }
}
