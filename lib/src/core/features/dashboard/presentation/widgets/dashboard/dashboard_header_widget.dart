import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/language_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';

class DashboardHeaderWidget extends StatelessWidget {
  final String userName;

  const DashboardHeaderWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final sidePadding = AppDimensions.paddingLg.width(context);
    return Container(
      color: cardGradientStartColor.withValues(alpha: 0.15),

      padding: EdgeInsets.only(
        left: sidePadding,
        right: sidePadding,
        top: sidePadding + 30.height(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: AppDimensions.spacingSm.width(context),
            children: [
              CircleAvatar(
                child: SizedBox(
                  width: 48.width(context),
                  height: 48.width(context),
                ),
              ),
              TextWidgetSm(
                text: '${context.translate(hello)}\n$userName',
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          LanguageButton(isDashboard: true),
        ],
      ),
    );
  }
}
