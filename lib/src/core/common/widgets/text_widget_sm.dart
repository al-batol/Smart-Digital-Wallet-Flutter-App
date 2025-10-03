import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';

class TextWidgetSm extends StatelessWidget {
  final String text;
  final Color? textColor;
  const TextWidgetSm({super.key, required this.text, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: AppDimensions.fontSm.fontSize(context),
        color: textColor,
      ),
    );
  }
}
