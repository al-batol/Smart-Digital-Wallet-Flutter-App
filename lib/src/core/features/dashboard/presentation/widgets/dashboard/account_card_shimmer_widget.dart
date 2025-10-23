import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';

class AccountCardShimmerWidget extends StatelessWidget {
  final double height;

  const AccountCardShimmerWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: cardGradientStartColor,
      highlightColor: cardGradientEndColor,
      child: Container(
        height: height * 0.72,
        width: ResponsiveHelper.screenWidth(context),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [cardGradientStartColor, cardGradientEndColor],
            stops: [0.6, 1],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.radiusXl.radius(context)),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(255, 165, 0, 0.2),
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
    );
  }
}
