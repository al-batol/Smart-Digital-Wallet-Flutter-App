import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/routes/app_route_names.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_sm.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/models/service_model.dart';

class ServiceWidget extends StatelessWidget {
  final ServiceModel service;

  const ServiceWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final state = context.read<DashboardBloc>().state;
        if (state.accounts != null && state.accounts!.accounts.isNotEmpty) {
          await context.push(
            service.routeName,
            extra: {'accounts': state.accounts!.accounts},
          );

          if (context.mounted) {
            context.read<DashboardBloc>().add(const GetLastTransactionsEvent());
          }
        }
      },
      child: Column(
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
          TextWidgetSm(text: context.translate(service.name)),
        ],
      ),
    );
  }
}
