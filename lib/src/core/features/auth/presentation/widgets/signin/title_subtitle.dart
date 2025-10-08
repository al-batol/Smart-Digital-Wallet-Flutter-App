import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';

class TitleSubtitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const TitleSubtitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidgetXl(text: title, textColor: textHeadlineColor),
        SizedBox(height: AppDimensions.spacingMd.height(context)),
        TextWidgetSm(text: subtitle, textColor: textHeadlineColor),
        SizedBox(height: AppDimensions.spacingXs.height(context)),
      ],
    );
  }
}
