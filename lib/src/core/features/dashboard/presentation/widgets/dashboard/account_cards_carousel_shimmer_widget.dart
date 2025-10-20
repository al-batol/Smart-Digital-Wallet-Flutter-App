import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/account_card_shimmer_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/decorative_circles_widget.dart';

class AccountCardsCarouselShimmerWidget extends StatelessWidget {
  final double height;

  const AccountCardsCarouselShimmerWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: ResponsiveHelper.screenWidth(context),
      child: Stack(
        children: [
          Container(
            width: ResponsiveHelper.screenWidth(context),
            height: height,
            color: primaryColor.withValues(alpha: 0.15),
          ),
          DecorativeCirclesWidget(height: height),
          Positioned(
            top: height * 0.1,
            left: AppDimensions.paddingLg.width(context),
            right: AppDimensions.paddingLg.width(context),
            child: AccountCardShimmerWidget(height: height),
          ),
        ],
      ),
    );
  }
}
