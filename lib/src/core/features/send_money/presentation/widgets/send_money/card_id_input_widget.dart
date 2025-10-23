import 'package:flutter/material.dart';
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
        const TextWidgetLg(
          text: 'Recipient Card ID',
          textColor: textHeadlineColor,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        TextFormField(
          controller: cardIdController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter card ID',
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
              return 'Please enter recipient card ID';
            }
            if (value.length != 16) {
              return 'Please enter a valid 16-digit card ID';
            }
            return null;
          },
        ),
      ],
    );
  }
}
