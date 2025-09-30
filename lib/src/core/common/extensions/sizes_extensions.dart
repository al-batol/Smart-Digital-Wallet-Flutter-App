import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';

extension ResponsiveDoubleExtension on double {
  double spacing(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) {
      return this;
    } else if (ResponsiveHelper.isTablet(context)) {
      return this * 1.25;
    }
    return this * 1.5;
  }

  double fontSize(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) {
      return this;
    } else if (ResponsiveHelper.isTablet(context)) {
      return this * 1.15;
    }
    return this * 1.3;
  }

  double height(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) {
      return this;
    } else if (ResponsiveHelper.isTablet(context)) {
      return this * 1.2;
    }
    return this * 1.4;
  }

  double width(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) {
      return this;
    } else if (ResponsiveHelper.isTablet(context)) {
      return this * 1.2;
    }
    return this * 1.4;
  }

  // Radius
  double radius(BuildContext context) {
    if (ResponsiveHelper.isMobile(context)) {
      return this;
    } else if (ResponsiveHelper.isTablet(context)) {
      return this * 1.25;
    }
    return this * 1.5;
  }
}

extension ResponsiveIntExtension on int {
  double spacing(BuildContext context) => toDouble().spacing(context);
  double fontSize(BuildContext context) => toDouble().fontSize(context);
  double height(BuildContext context) => toDouble().height(context);
  double width(BuildContext context) => toDouble().width(context);
  double radius(BuildContext context) => toDouble().radius(context);
}
