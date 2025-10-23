import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';

class TextWidgetLg extends StatelessWidget {
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;
  const TextWidgetLg({
    super.key,
    required this.text,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: AppDimensions.fontLg.fontSize(context),
        color: textColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
