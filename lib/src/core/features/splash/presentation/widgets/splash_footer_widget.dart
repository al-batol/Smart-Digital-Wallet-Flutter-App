import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';

class SplashFooterWidget extends StatelessWidget {
  final Animation<double> animation;

  const SplashFooterWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        children: [
          Container(
            width: (AppDimensions.spacingXl + AppDimensions.spacingMd).width(
              context,
            ),
            height: AppDimensions.borderWidthThick.height(context),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusSm.radius(context),
              ),
            ),
          ),
          SizedBox(height: AppDimensions.spacingLg.height(context)),
          TextWidgetSm(
            text: context.translate('version'),
            textColor: Colors.white.withValues(alpha: 0.6),
          ),
          SizedBox(height: AppDimensions.spacingSm.height(context)),
        ],
      ),
    );
  }
}
