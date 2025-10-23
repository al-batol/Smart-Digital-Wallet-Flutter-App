import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/models/service_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/service_widget.dart';

class ServicesSectionWidget extends StatelessWidget {
  const ServicesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextWidgetMd(text: 'Services', fontWeight: FontWeight.bold),
        SizedBox(height: AppDimensions.spacingMd.height(context)),
        Row(
          spacing: AppDimensions.spacingMd.width(context),
          children: ServiceModel.services
              .map((service) => ServiceWidget(service: service))
              .toList(),
        ),
      ],
    );
  }
}
