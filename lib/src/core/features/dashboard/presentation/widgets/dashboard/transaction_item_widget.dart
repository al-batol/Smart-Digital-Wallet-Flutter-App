import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart'
    as colors;
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/transaction_details_dialog.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItemWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) =>
              TransactionDetailsDialog(transaction: transaction),
        );
      },
      child: Container(
        padding: EdgeInsets.all(AppDimensions.spacingSm.width(context)),
        margin: EdgeInsets.only(
          bottom: AppDimensions.spacingXs.height(context),
        ),
        decoration: BoxDecoration(
          color: colors.softLightColor,
          borderRadius: BorderRadius.circular(
            AppDimensions.radiusMd.toDouble(),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppDimensions.spacingXs.width(context)),
              decoration: BoxDecoration(
                color: _getTypeColor(transaction.type).withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusSm.toDouble(),
                ),
              ),
              child: Icon(
                _getTypeIcon(transaction.type),
                color: _getTypeColor(transaction.type),
                size: 20,
              ),
            ),
            SizedBox(width: AppDimensions.spacingSm.width(context)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Builder(
                    builder: (context) => TextWidgetMd(
                      text: context.translate(_getTypeLabel(transaction.type)),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  TextWidgetSm(
                    text: '${transaction.amount} ${transaction.currency}',
                    textColor: colors.textSecondaryColor,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textSecondaryColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeLabel(String? type) {
    switch (type) {
      case 'topup':
        return 'top_up';
      case 'sendmoney':
        return 'send_money';
      case 'paybill':
        return 'pay_bill';
      default:
        return 'transaction';
    }
  }

  IconData _getTypeIcon(String? type) {
    switch (type) {
      case 'topup':
        return Icons.arrow_downward_rounded;
      case 'sendmoney':
        return Icons.arrow_upward_rounded;
      case 'paybill':
        return Icons.receipt_long_rounded;
      default:
        return Icons.sync_alt_rounded;
    }
  }

  Color _getTypeColor(String? type) {
    switch (type) {
      case 'topup':
        return Colors.green;
      case 'sendmoney':
        return Colors.orange;
      case 'paybill':
        return Colors.blue;
      default:
        return colors.primaryColor;
    }
  }
}
