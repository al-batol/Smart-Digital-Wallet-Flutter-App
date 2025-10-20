import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_constants.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/svg_image.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_lg.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/blocs/bloc/dashboard_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/presentation/widgets/dashboard/currency_chip_widget.dart';

class AccountCardWidget extends StatelessWidget {
  final AccountEntity account;
  final double height;
  const AccountCardWidget({
    super.key,
    required this.account,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.72,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cardGradientStartColor, cardGradientEndColor],
          stops: [0.6, 1],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(AppDimensions.radiusXl.radius(context)),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(255, 165, 0, 0.2),
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                top: AppDimensions.paddingLg.width(context),
                left: AppDimensions.paddingXl.width(context),
                right: AppDimensions.paddingXl.width(context),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidgetMd(
                          text: account.type.name.replaceFirst(
                            account.type.name[0],
                            account.type.name[0].toUpperCase(),
                          ),
                          textColor: textMainColor,
                          fontWeight: FontWeight.w600,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: AppDimensions.spacingSm.width(context),
                          children: account.currencyBalances!
                              .asMap()
                              .entries
                              .map(
                                (entry) =>
                                    BlocBuilder<DashboardBloc, DashboardState>(
                                      buildWhen: (previous, current) =>
                                          previous.selectedCurrencyIndex !=
                                          current.selectedCurrencyIndex,
                                      builder: (context, state) {
                                        return CurrencyChipWidget(
                                          onTap: () {
                                            context.read<DashboardBloc>().add(
                                              ToggleSelectedCurrencyEvent(
                                                index: entry.key,
                                              ),
                                            );
                                          },
                                          currency:
                                              entry.value.currency.currency,
                                          isSelected:
                                              state.selectedCurrencyIndex ==
                                              entry.key,
                                        );
                                      },
                                    ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: account.id
                          .split(',')
                          .map(
                            (e) =>
                                TextWidgetXl(text: e, textColor: textMainColor),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXl.width(context),
                vertical: 2,
              ),
              width: ResponsiveHelper.screenWidth(context),
              decoration: BoxDecoration(
                color: cardGradientEndColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    AppDimensions.radiusXl.radius(context),
                  ),
                  bottomRight: Radius.circular(
                    AppDimensions.radiusXl.radius(context),
                  ),
                ),
                border: Border(
                  top: BorderSide(
                    color: textMainColor.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextWidgetMd(
                            text: 'Balance',
                            textColor: textMainColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: BlocBuilder<DashboardBloc, DashboardState>(
                            buildWhen: (previous, current) =>
                                previous.selectedCurrencyIndex !=
                                    current.selectedCurrencyIndex ||
                                previous.isBalanceVisible !=
                                    current.isBalanceVisible,
                            builder: (context, state) {
                              final currency =
                                  account.currencyBalances![state
                                      .selectedCurrencyIndex];

                              String? balance = currency.balance.toString();
                              if (!state.isBalanceVisible) {
                                balance = double.tryParse(balance)
                                    ?.ceil()
                                    .toString()
                                    .replaceAll(RegExp(r'\d'), '*');
                              }
                              return TextWidgetLg(
                                text: '$balance ${currency.currency.symbol}',
                                textColor: textMainColor,
                                fontWeight: FontWeight.w500,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<DashboardBloc, DashboardState>(
                    buildWhen: (previous, current) =>
                        previous.isBalanceVisible != current.isBalanceVisible,
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () => context.read<DashboardBloc>().add(
                          ToggleBalanceVisibilityEvent(),
                        ),
                        child: SvgImage(
                          path: state.isBalanceVisible ? eyeOffImg : eyeOnImg,
                          color: textMainColor,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
