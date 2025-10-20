import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart'
    show softLightColor;
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/models/service_model.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceModel service;

  const ServiceWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppDimensions.spacingSm.height(context),
      children: [
        Container(
          padding: EdgeInsets.all(AppDimensions.paddingLg.width(context)),
          decoration: BoxDecoration(
            color: softLightColor,
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusXl.radius(context),
            ),
          ),
          child: SvgImage(
            path: service.icon,
            height: AppDimensions.iconMd.height(context).toInt(),
            width: AppDimensions.iconMd.width(context).toInt(),
            fit: BoxFit.contain,
          ),
        ),

        TextWidgetSm(text: service.name),
      ],
    );
  }
}
