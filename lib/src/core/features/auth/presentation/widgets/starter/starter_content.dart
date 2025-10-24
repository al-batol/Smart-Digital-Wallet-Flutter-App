import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_3xl.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';

class StarterContent extends StatelessWidget {
  const StarterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppDimensions.paddingLg.width(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          TextWidget3xl(
            text: context.translate(digitalWallet),
            textColor: textHeadlineColor,
          ),
          SizedBox(height: AppDimensions.spacingMd.height(context)),
          SvgImage(path: sunImg),
          SizedBox(height: AppDimensions.spacingSm.height(context)),
          TextWidgetSm(
            text: context.translate(openAccountDescription),
            textColor: textSecondaryColor,
          ),
          SizedBox(height: AppDimensions.spacingMd.height(context)),
          TextWidgetSm(
            text: context.translate(joinForFree),
            textColor: textSecondaryColor,
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(
                AppDimensions.buttonHeight.height(context),
              ), // full width button
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusLg.radius(context),
                ),
              ),
            ),
            onPressed: () {
              context.push(signInRoute);
            },
            child: TextWidgetMd(
              text: context.translate(getStarted),
              textColor: textButtonColor,
            ),
          ),
          SizedBox(height: AppDimensions.spacingLg.height(context)),
          TextWidgetMd(
            text: context.translate(dontHaveAccount),
            textColor: textButtonColor.withValues(alpha: 0.8),
          ),
          TextWidgetMd(
            text: context.translate(contactUs),
            textColor: primaryColor.withValues(alpha: 0.9),
          ),
          SizedBox(height: AppDimensions.spacingLg.height(context)),
        ],
      ),
    );
  }
}
