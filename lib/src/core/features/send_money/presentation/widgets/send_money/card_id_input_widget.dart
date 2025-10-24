import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_lg.dart';

class CardIdInputWidget extends StatelessWidget {
  final TextEditingController cardIdController;

  const CardIdInputWidget({super.key, required this.cardIdController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidgetLg(
          text: context.translate(recipientCardId),
          textColor: textHeadlineColor,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        TextFormField(
          controller: cardIdController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: context.translate(enterCardIdPlaceholder),
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
                color: primaryColor.withValues(alpha: 0.5),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorTextColor.withValues(alpha: 0.5),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: errorTextColor.withValues(alpha: 0.5),
              ),
            ),
            contentPadding: EdgeInsets.all(
              AppDimensions.paddingSm.width(context),
            ),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return context.translate(enterRecipientCardId);
            }
            if (value.length != 16) {
              return context.translate(valid16DigitCardId);
            }
            return null;
          },
        ),
      ],
    );
  }
}
