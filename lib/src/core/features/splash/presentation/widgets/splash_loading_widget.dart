import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';

class SplashLoadingWidget extends StatelessWidget {
  final Animation<double> animation;

  const SplashLoadingWidget({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            (1 - animation.value) * AppDimensions.spacingXl.height(context),
          ),
          child: Column(
            children: [
              SizedBox(
                width: (AppDimensions.iconXl + AppDimensions.spacingMd).width(
                  context,
                ),
                height: (AppDimensions.iconXl + AppDimensions.spacingMd).height(
                  context,
                ),
                child: CircularProgressIndicator(
                  strokeWidth: AppDimensions.borderWidthThick.height(context),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white.withValues(alpha: 0.9),
                  ),
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
