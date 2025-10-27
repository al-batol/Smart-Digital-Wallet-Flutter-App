import 'package:flutter/material.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_colors.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_dimensions.dart';
import 'package:smart_digital_wallet/src/core/common/extensions/sizes_extensions.dart';
import 'package:smart_digital_wallet/src/core/common/helper/loading_dialog.dart';
import 'package:smart_digital_wallet/src/core/common/helper/responsive_helper.dart';
import 'package:smart_digital_wallet/src/core/common/helper/snack_bars.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/amount_input_widget.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/app_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_lg.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/blocs/bloc/currency_exchange_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/widgets/currency_exchange/from_account_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/widgets/currency_exchange/to_account_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/widgets/currency_exchange/from_currency_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/widgets/currency_exchange/to_currency_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/presentation/widgets/currency_exchange/exchange_rate_display_widget.dart';

class CurrencyExchangeView extends StatefulWidget {
  final List<AccountEntity> accounts;

  const CurrencyExchangeView({super.key, required this.accounts});

  @override
  State<CurrencyExchangeView> createState() => _CurrencyExchangeViewState();
}

class _CurrencyExchangeViewState extends State<CurrencyExchangeView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _amountController = TextEditingController();

    if (widget.accounts.isNotEmpty) {
      context.read<CurrencyExchangeBloc>().add(
        SelectFromAccountEvent(account: widget.accounts.first),
      );
      context.read<CurrencyExchangeBloc>().add(
        SelectToAccountEvent(account: widget.accounts.first),
      );
    }

    _amountController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetXl(
          text: context.translate(currencyExchange),
          textColor: textHeadlineColor,
        ),
        backgroundColor: primaryColor.withValues(alpha: 0.15),
      ),
      body: BlocListener<CurrencyExchangeBloc, CurrencyExchangeState>(
        listenWhen: (previous, current) =>
            previous.isLoading != current.isLoading ||
            previous.errorMessage != current.errorMessage ||
            previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          if (state.isLoading) {
            showLoadingDialog(context);
          } else {
            if (context.canPop()) {
              context.pop();
            }
          }
          if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                failureSnackBar(
                  title: context.translate(error),
                  message: context.translate(state.errorMessage),
                ),
              );
          }
          if (state.isSuccess && state.exchangeResult != null) {
            if (context.canPop()) {
              context.pop();
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  successSnackBar(
                    title: context.translate(success),
                    message: state.exchangeResult!.message,
                  ),
                );
            }
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: ResponsiveHelper.screenWidth(context),
              padding: EdgeInsets.all(AppDimensions.paddingLg.width(context)),
              child: Form(
                key: _formKey,
                child: BlocBuilder<CurrencyExchangeBloc, CurrencyExchangeState>(
                  builder: (context, state) {
                    // Check if accounts list is empty
                    if (widget.accounts.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                            AppDimensions.paddingLg.width(context),
                          ),
                          child: TextWidgetLg(
                            text: context.translate('no_accounts_available'),
                            textColor: textSecondaryColor,
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FromAccountSelectorWidget(
                          accounts: widget.accounts,
                          selectedAccount: widget.accounts.first,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        BlocBuilder<
                          CurrencyExchangeBloc,
                          CurrencyExchangeState
                        >(
                          buildWhen: (previous, current) =>
                              previous.fromAccount != current.fromAccount,
                          builder: (context, state) {
                            return FromCurrencySelectorWidget(
                              selectedAccount: state.fromAccount,
                            );
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        ToAccountSelectorWidget(
                          accounts: widget.accounts,
                          selectedAccount: widget.accounts.first,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        BlocBuilder<
                          CurrencyExchangeBloc,
                          CurrencyExchangeState
                        >(
                          buildWhen: (previous, current) =>
                              previous.toAccount != current.toAccount,
                          builder: (context, state) {
                            return ToCurrencySelectorWidget(
                              selectedAccount: state.toAccount,
                            );
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        BlocBuilder<
                          CurrencyExchangeBloc,
                          CurrencyExchangeState
                        >(
                          buildWhen: (previous, current) =>
                              previous.fromAccount != current.fromAccount ||
                              previous.fromCurrencyIndex !=
                                  current.fromCurrencyIndex,
                          builder: (context, state) {
                            double? maxAmount;
                            String? currency;
                            if (state.fromAccount != null &&
                                state.fromAccount!.currencyBalances != null &&
                                state
                                    .fromAccount!
                                    .currencyBalances!
                                    .isNotEmpty &&
                                state.fromCurrencyIndex <
                                    state
                                        .fromAccount!
                                        .currencyBalances!
                                        .length) {
                              final selectedCurrency = state
                                  .fromAccount!
                                  .currencyBalances![state.fromCurrencyIndex];
                              maxAmount = selectedCurrency.balance;
                              currency = selectedCurrency.currency.currency;
                            }
                            return AmountInputWidget(
                              amountController: _amountController,
                              maxAmount: maxAmount,
                              currency: currency,
                            );
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        ExchangeRateDisplayWidget(
                          amount:
                              double.tryParse(_amountController.text) ?? 0.0,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingXl.height(context),
                        ),
                        BlocBuilder<
                          CurrencyExchangeBloc,
                          CurrencyExchangeState
                        >(
                          buildWhen: (previous, current) =>
                              previous.fromAccount != current.fromAccount ||
                              previous.toAccount != current.toAccount ||
                              previous.fromCurrencyIndex !=
                                  current.fromCurrencyIndex ||
                              previous.toCurrencyIndex !=
                                  current.toCurrencyIndex,
                          builder: (context, state) {
                            return AppButton(
                              text: context.translate(confirmCurrencyExchange),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    state.fromAccount != null &&
                                    state.toAccount != null &&
                                    state.fromAccount!.currencyBalances !=
                                        null &&
                                    state.toAccount!.currencyBalances != null &&
                                    state
                                        .fromAccount!
                                        .currencyBalances!
                                        .isNotEmpty &&
                                    state
                                        .toAccount!
                                        .currencyBalances!
                                        .isNotEmpty &&
                                    state.fromCurrencyIndex <
                                        state
                                            .fromAccount!
                                            .currencyBalances!
                                            .length &&
                                    state.toCurrencyIndex <
                                        state
                                            .toAccount!
                                            .currencyBalances!
                                            .length) {
                                  final fromCurrency =
                                      state.fromAccount!.currencyBalances![state
                                          .fromCurrencyIndex];
                                  final toCurrency = state
                                      .toAccount!
                                      .currencyBalances![state.toCurrencyIndex];

                                  context.read<CurrencyExchangeBloc>().add(
                                    ConfirmExchangeEvent(
                                      fromAccountId: state.fromAccount!.id,
                                      toAccountId: state.toAccount!.id,
                                      fromCurrency:
                                          fromCurrency.currency.currency,
                                      toCurrency: toCurrency.currency.currency,
                                      amount: double.parse(
                                        _amountController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
