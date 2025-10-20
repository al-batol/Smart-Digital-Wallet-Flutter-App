import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/account_cards_carousel_shimmer_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/account_cards_carousel_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/dashboard_header_widget.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/services_section_widget.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardHeaderWidget(userName: 'John Doe'),
          BlocBuilder<DashboardBloc, DashboardState>(
            buildWhen: (previous, current) =>
                previous.isLoading != current.isLoading ||
                previous.accounts != current.accounts ||
                previous.errorMessage != current.errorMessage,
            builder: (context, state) {
              if (state.isLoading) {
                return AccountCardsCarouselShimmerWidget(
                  height: screenHeight * 0.3,
                );
              }
              if (state.accounts != null &&
                  state.accounts!.accounts.isNotEmpty) {
                return AccountCardsCarouselWidget(
                  height: screenHeight * 0.29,
                  accounts: state.accounts!.accounts,
                );
              }
              if (state.errorMessage.isNotEmpty) {
                return Center(child: Text(state.errorMessage));
              }
              return const SizedBox.shrink();
            },
          ),
          SizedBox(height: AppDimensions.spacingXl.height(context) - 2),
          const Expanded(child: ServicesSectionWidget()),
        ],
      ),
    );
  }
}
