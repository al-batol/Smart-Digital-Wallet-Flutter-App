import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';

class DecorativeCirclesWidget extends StatelessWidget {
  final double height;
  final bool? disableRightCircle;
  final bool? disableLeftCircle;
  const DecorativeCirclesWidget({
    super.key,
    required this.height,
    this.disableRightCircle = false,
    this.disableLeftCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final circleSize = height / 1.6;
    final topPosition = height * 0.15;
    final sidePosition = -height * 0.328;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Stack(
      children: [
        if (!disableRightCircle!)
          Positioned(
            top: topPosition,
            right: isArabic ? null : sidePosition,
            left: isArabic ? sidePosition : null,
            child: Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.radiusFull.radius(context)),
                ),
                border: Border.all(
                  color: primaryColor,
                  width: 20,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
        if (!disableLeftCircle!)
          Positioned(
            top: topPosition,
            left: isArabic ? null : sidePosition,
            right: isArabic ? sidePosition : null,
            child: Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimensions.radiusFull.radius(context)),
                ),
                border: Border.all(
                  color: primaryColor,
                  width: 20,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
