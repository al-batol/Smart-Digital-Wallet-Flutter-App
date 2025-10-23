import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';

class DropdownSelectorWidget<T> extends StatelessWidget {
  final String title;
  final String subtitle;
  final T? selectedValue;
  final List<T> items;
  final String Function(T) displayText;
  final ValueChanged<T?> onChanged;

  const DropdownSelectorWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selectedValue,
    required this.items,
    required this.displayText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidgetMd(
          text: title,
          textColor: textHeadlineColor,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        TextWidgetSm(text: subtitle, textColor: textSecondaryColor),
        SizedBox(height: AppDimensions.spacingSm.height(context)),
        DropdownButtonFormField<T>(
          initialValue: selectedValue,
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
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: TextWidgetMd(
                text: displayText(item),
                textColor: textMainColor,
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
