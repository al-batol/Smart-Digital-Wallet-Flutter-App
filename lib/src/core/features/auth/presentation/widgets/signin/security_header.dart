import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';

class SecurityHeader extends StatelessWidget {
  const SecurityHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveHelper.screenWidth(context),
      color: primaryColor.withValues(alpha: 0.15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppDimensions.spacingSm.spacing(context),
        children: [
          SvgImage(
            path: securityImg,
            height: 178,
            width: 143,
            fit: BoxFit.contain,
          ),
          SvgImage(
            path: shadowCircleImg,
            height: 8,
            width: 156,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
