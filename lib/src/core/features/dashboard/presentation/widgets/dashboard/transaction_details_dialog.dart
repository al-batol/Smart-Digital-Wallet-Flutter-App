import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart'
    as colors;
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_lg.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';

class TransactionDetailsDialog extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailsDialog({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg.toDouble()),
      ),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.spacingMd.width(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidgetLg(
                  text: context.translate(transactionDetails),
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: AppDimensions.spacingMd.height(context)),
            _buildDetailRow(
              context.translate(type),
              context.translate(_getTypeLabel(transaction.type)),
            ),
            _buildDetailRow(
              context.translate(amount),
              '${transaction.amount} ${transaction.currency}',
            ),
            _buildDetailRow(
              context.translate(accountId),
              transaction.accountId ?? '-',
            ),
            if (transaction.type == 'sendmoney') ...[
              _buildDetailRow(
                context.translate(recipientId),
                transaction.recipientAccountId ?? '-',
              ),
            ],
            if (transaction.type == 'paybill') ...[
              _buildDetailRow(
                context.translate(billType),
                transaction.billType != null
                    ? context.translate(transaction.billType!)
                    : '-',
              ),
              _buildDetailRow(
                context.translate(billNumber),
                transaction.number ?? '-',
              ),
            ],
            if (transaction.type == 'topup') ...[
              if (transaction.provider != null)
                _buildDetailRow(
                  context.translate(selectedProvider),
                  context.translate(transaction.provider!),
                ),
              _buildDetailRow(
                context.translate(phoneNumber),
                transaction.number ?? '-',
              ),
            ],
            if (transaction.id != null)
              _buildDetailRow(
                context.translate(transactionId),
                transaction.id!,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: TextWidgetMd(
              text: label,
              textColor: colors.textSecondaryColor,
            ),
          ),
          Expanded(
            flex: 3,
            child: TextWidgetMd(text: value, fontWeight: FontWeight.w600),
          ),
        ],
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
}
