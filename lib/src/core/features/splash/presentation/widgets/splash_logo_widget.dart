import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';

class SplashLogoWidget extends StatelessWidget {
  final Animation<double> logoAnimation;
  final Animation<double> pulseAnimation;

  const SplashLogoWidget({
    super.key,
    required this.logoAnimation,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([logoAnimation, pulseAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: logoAnimation.value * pulseAnimation.value,
          child: Container(
            padding: EdgeInsets.all(AppDimensions.paddingLg.width(context)),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: AppDimensions.iconXl.height(context),
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Image.asset(
              appLogoImg,
              width: (AppDimensions.icon3xl * 2 + AppDimensions.spacingLg)
                  .width(context),
              height: (AppDimensions.icon3xl * 2 + AppDimensions.spacingLg)
                  .height(context),
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
