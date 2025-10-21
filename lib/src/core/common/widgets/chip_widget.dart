import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';

class ChipWidget extends StatelessWidget {
  final String currency;
  final bool isSelected;
  final VoidCallback onTap;
  const ChipWidget({
    super.key,
    required this.currency,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: AppDimensions.paddingXs.width(context),
          horizontal: AppDimensions.paddingMd.width(context),
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor
              : primaryColor.withValues(alpha: 0.5),
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.radiusXl.radius(context)),
          ),
        ),
        child: TextWidgetSm(
          text: currency,
          textColor: textMainColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
