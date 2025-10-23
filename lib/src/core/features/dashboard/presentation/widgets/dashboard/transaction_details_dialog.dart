import 'package:flutter/material.dart';
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
                  text: 'Transaction Details',
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
            _buildDetailRow('Type', _getTypeLabel(transaction.type)),
            _buildDetailRow(
              'Amount',
              '${transaction.amount} ${transaction.currency}',
            ),
            _buildDetailRow('Account ID', transaction.accountId ?? '-'),
            if (transaction.type == 'sendmoney') ...[
              _buildDetailRow(
                'Recipient ID',
                transaction.recipientAccountId ?? '-',
              ),
            ],
            if (transaction.type == 'paybill') ...[
              _buildDetailRow('Bill Type', transaction.billType ?? '-'),
              _buildDetailRow('Bill Number', transaction.billNumber ?? '-'),
            ],
            if (transaction.id != null)
              _buildDetailRow('Transaction ID', transaction.id!),
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
        return 'Top Up';
      case 'sendmoney':
        return 'Send Money';
      case 'paybill':
        return 'Pay Bill';
      default:
        return 'Transaction';
    }
  }
}
