import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_lg.dart';

class NumberInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const NumberInputWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.validator,
    this.keyboardType = TextInputType.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextWidgetLg(
          text: context.translate(label),
          textColor: textHeadlineColor,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+'))],
          decoration: InputDecoration(
            hintText: context.translate(hintText),
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
          validator: validator,
        ),
      ],
    );
  }
}
