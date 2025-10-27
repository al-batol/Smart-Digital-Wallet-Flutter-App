import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_md.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/blocs/bloc/currency_exchange_bloc.dart';

class ExchangeRateDisplayWidget extends StatelessWidget {
  final double amount;

  const ExchangeRateDisplayWidget({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyExchangeBloc, CurrencyExchangeState>(
      buildWhen: (previous, current) =>
          previous.fromAccount != current.fromAccount ||
          previous.toAccount != current.toAccount ||
          previous.fromCurrencyIndex != current.fromCurrencyIndex ||
          previous.toCurrencyIndex != current.toCurrencyIndex,
      builder: (context, state) {
        if (state.fromAccount == null ||
            state.toAccount == null ||
            state.fromAccount!.currencyBalances == null ||
            state.toAccount!.currencyBalances == null ||
            amount <= 0) {
          return const SizedBox.shrink();
        }

        final fromCurrency =
            state.fromAccount!.currencyBalances![state.fromCurrencyIndex];
        final toCurrency =
            state.toAccount!.currencyBalances![state.toCurrencyIndex];

        final exchangeRate = _getExchangeRate(
          fromCurrency.currency.currency,
          toCurrency.currency.currency,
        );

        if (exchangeRate == 0.0) {
          return Container(
            padding: EdgeInsets.all(AppDimensions.paddingMd.width(context)),
            decoration: BoxDecoration(
              color: errorTextColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                AppDimensions.radiusMd.width(context),
              ),
            ),
            child: Center(
              child: TextWidgetMd(
                text: context.translate('exchange_not_allowed'),
                textColor: errorTextColor,
              ),
            ),
          );
        }

        final convertedAmount = amount * exchangeRate;

        return Container(
          padding: EdgeInsets.all(AppDimensions.paddingMd.width(context)),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(
              AppDimensions.radiusMd.width(context),
            ),
          ),
          child: Column(
            children: [
              TextWidgetMd(
                text: context.translate('exchange_rate'),
                textColor: textSecondaryColor,
              ),
              SizedBox(height: AppDimensions.spacingSm.height(context)),
              TextWidgetMd(
                text:
                    '1 ${fromCurrency.currency.currency} = ${exchangeRate.toStringAsFixed(4)} ${toCurrency.currency.currency}',
                textColor: textHeadlineColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: AppDimensions.spacingSm.height(context)),
              Divider(color: textSecondaryColor.withValues(alpha: 0.3)),
              SizedBox(height: AppDimensions.spacingSm.height(context)),
              TextWidgetMd(
                text: context.translate('you_will_receive'),
                textColor: textSecondaryColor,
              ),
              SizedBox(height: AppDimensions.spacingSm.height(context)),
              TextWidgetMd(
                text:
                    '${convertedAmount.toStringAsFixed(2)} ${toCurrency.currency.currency}',
                textColor: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        );
      },
    );
  }

  double _getExchangeRate(String fromCurrency, String toCurrency) {
    if (fromCurrency == toCurrency) {
      return 1.0;
    }

    // USD to YER
    if (fromCurrency == AccountCurrency.usd.currency &&
        toCurrency == AccountCurrency.yer.currency) {
      return 530.0;
    }

    // YER to USD
    if (fromCurrency == AccountCurrency.yer.currency &&
        toCurrency == AccountCurrency.usd.currency) {
      return 1.0 / 530.0;
    }

    // SAR to YER
    if (fromCurrency == AccountCurrency.sar.currency &&
        toCurrency == AccountCurrency.yer.currency) {
      return 140.0;
    }

    // YER to SAR
    if (fromCurrency == AccountCurrency.yer.currency &&
        toCurrency == AccountCurrency.sar.currency) {
      return 1.0 / 140.0;
    }

    // USD to SAR or SAR to USD - NOT ALLOWED
    if ((fromCurrency == AccountCurrency.usd.currency &&
            toCurrency == AccountCurrency.sar.currency) ||
        (fromCurrency == AccountCurrency.sar.currency &&
            toCurrency == AccountCurrency.usd.currency)) {
      return 0.0; // Not allowed
    }

    return 0.0; // Default: not allowed
  }
}
