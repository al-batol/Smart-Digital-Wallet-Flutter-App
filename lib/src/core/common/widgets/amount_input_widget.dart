import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:flutter/services.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';

class AmountInputWidget extends StatelessWidget {
  final TextEditingController amountController;
  final double? maxAmount;
  final String? currency;

  const AmountInputWidget({
    super.key,
    required this.amountController,
    this.maxAmount,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidgetMd(
          text: context.translate(enterAmount),
          textColor: textHeadlineColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidgetSm(
              text: context.translate(amountLabel),
              textColor: textSecondaryColor,
            ),
            if (maxAmount != null && currency != null)
              TextWidgetSm(
                text:
                    '${context.translate(available)}: ${maxAmount!.toStringAsFixed(2)} $currency',
                textColor: textSecondaryColor,
              ),
          ],
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        TextFormField(
          controller: amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          decoration: InputDecoration(
            hintText: context.translate(amountPlaceholder),
            hintStyle: const TextStyle(color: hintTextFieldColor),
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
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorTextColor.withValues(alpha: 0.2),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: textHeadlineColor.withValues(alpha: 0.2),
              ),
            ),
            contentPadding: EdgeInsets.all(
              AppDimensions.paddingSm.width(context),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.translate(amountRequired);
            }
            final amount = double.tryParse(value);
            if (amount == null) {
              return context.translate(invalidAmount);
            }
            if (amount <= 0) {
              return context.translate(amountGreaterThanZero);
            }
            if (maxAmount != null && amount > maxAmount!) {
              return '${context.translate(insufficientBalanceMax)}: ${maxAmount!.toStringAsFixed(2)}';
            }
            return null;
          },
        ),
      ],
    );
  }
}
