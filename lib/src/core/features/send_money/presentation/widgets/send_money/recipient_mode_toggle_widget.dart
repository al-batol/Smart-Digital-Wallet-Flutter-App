import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_lg.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';

class RecipientModeToggleWidget extends StatelessWidget {
  const RecipientModeToggleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      buildWhen: (previous, current) =>
          previous.useBeneficiary != current.useBeneficiary,
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusMd.toDouble(),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<SendMoneyBloc>().add(
                      const ToggleRecipientModeEvent(useBeneficiary: false),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingSm.height(context),
                    ),
                    decoration: BoxDecoration(
                      color: !state.useBeneficiary
                          ? primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMd.toDouble(),
                      ),
                    ),
                    child: Center(
                      child: TextWidgetLg(
                        text: 'Enter Card ID',
                        textColor: !state.useBeneficiary
                            ? Colors.white
                            : textSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    context.read<SendMoneyBloc>().add(
                      const ToggleRecipientModeEvent(useBeneficiary: true),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.paddingSm.height(context),
                    ),
                    decoration: BoxDecoration(
                      color: state.useBeneficiary
                          ? primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusMd.toDouble(),
                      ),
                    ),
                    child: Center(
                      child: TextWidgetLg(
                        text: 'Beneficiaries',
                        textColor: state.useBeneficiary
                            ? Colors.white
                            : textSecondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
