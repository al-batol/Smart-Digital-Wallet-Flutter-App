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
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/widgets/send_money/account_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/widgets/send_money/beneficiary_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/widgets/send_money/card_id_input_widget.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/widgets/send_money/currency_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/widgets/send_money/recipient_mode_toggle_widget.dart';

class SendMoneyView extends StatefulWidget {
  final List<AccountEntity> accounts;

  const SendMoneyView({super.key, required this.accounts});

  @override
  State<SendMoneyView> createState() => _SendMoneyViewState();
}

class _SendMoneyViewState extends State<SendMoneyView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _amountController;
  late final TextEditingController _cardIdController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _amountController = TextEditingController();
    _cardIdController = TextEditingController();
    context.read<SendMoneyBloc>().add(const GetBeneficiariesEvent());
    context.read<SendMoneyBloc>().add(
      SelectAccountEvent(account: widget.accounts.first),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _cardIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetXl(
          text: context.translate(sendMoney),
          textColor: textHeadlineColor,
        ),
        backgroundColor: primaryColor.withValues(alpha: 0.15),
      ),
      body: BlocListener<SendMoneyBloc, SendMoneyState>(
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
          if (state.isSuccess && state.sendMoneyResult != null) {
            if (context.canPop()) {
              context.pop();
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  successSnackBar(
                    title: context.translate(success),
                    message: state.sendMoneyResult!.message,
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
              child: BlocBuilder<SendMoneyBloc, SendMoneyState>(
                buildWhen: (previous, current) =>
                    previous.beneficiaries != current.beneficiaries ||
                    previous.isLoading != current.isLoading,
                builder: (context, state) {
                  if (state.isLoading && state.beneficiaries.isEmpty) {
                    return Center(
                      child: TextWidgetLg(
                        text: context.translate(loadingBeneficiaries),
                        textColor: textSecondaryColor,
                      ),
                    );
                  }

                  return Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (state.beneficiaries.isNotEmpty)
                          const RecipientModeToggleWidget(),
                        if (state.beneficiaries.isNotEmpty)
                          SizedBox(
                            height: AppDimensions.spacingMd.height(context),
                          ),
                        BlocBuilder<SendMoneyBloc, SendMoneyState>(
                          buildWhen: (previous, current) =>
                              previous.useBeneficiary != current.useBeneficiary,
                          builder: (context, state) {
                            if (!state.useBeneficiary) {
                              return CardIdInputWidget(
                                cardIdController: _cardIdController,
                              );
                            } else if (state.beneficiaries.isNotEmpty) {
                              return BeneficiarySelectorWidget(
                                beneficiaries: state.beneficiaries,
                              );
                            } else {
                              return TextWidgetLg(
                                text: context.translate(
                                  'no_beneficiaries_found',
                                ),
                                textColor: textSecondaryColor,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        AccountSelectorWidget(
                          accounts: widget.accounts,
                          selectedAccount: widget.accounts.first,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        BlocBuilder<SendMoneyBloc, SendMoneyState>(
                          buildWhen: (previous, current) =>
                              previous.selectedAccount !=
                              current.selectedAccount,
                          builder: (context, state) {
                            return CurrencySelectorWidget(
                              selectedAccount: state.selectedAccount,
                            );
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        BlocBuilder<SendMoneyBloc, SendMoneyState>(
                          buildWhen: (previous, current) =>
                              previous.selectedAccount !=
                                  current.selectedAccount ||
                              previous.selectedCurrencyIndex !=
                                  current.selectedCurrencyIndex,
                          builder: (context, state) {
                            double? maxAmount;
                            String? currency;
                            if (state.selectedAccount != null &&
                                state.selectedAccount!.currencyBalances !=
                                    null &&
                                state
                                    .selectedAccount!
                                    .currencyBalances!
                                    .isNotEmpty) {
                              final selectedCurrency =
                                  state.selectedAccount!.currencyBalances![state
                                      .selectedCurrencyIndex];
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
                          height: AppDimensions.spacingXl.height(context),
                        ),
                        BlocBuilder<SendMoneyBloc, SendMoneyState>(
                          buildWhen: (previous, current) =>
                              previous.selectedAccount !=
                                  current.selectedAccount ||
                              previous.selectedBeneficiary !=
                                  current.selectedBeneficiary ||
                              previous.selectedCurrencyIndex !=
                                  current.selectedCurrencyIndex ||
                              previous.useBeneficiary != current.useBeneficiary,
                          builder: (context, state) {
                            return AppButton(
                              text: context.translate(confirmSendMoney),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    state.selectedAccount != null) {
                                  final selectedCurrency =
                                      state
                                          .selectedAccount!
                                          .currencyBalances![state
                                          .selectedCurrencyIndex];

                                  final recipientId = state.useBeneficiary
                                      ? state.selectedBeneficiary?.id ?? ''
                                      : _cardIdController.text.trim();

                                  context.read<SendMoneyBloc>().add(
                                    ConfirmSendMoneyEvent(
                                      recipientAccountId: recipientId,
                                      sourceAccountId:
                                          state.selectedAccount!.id,
                                      currency:
                                          selectedCurrency.currency.currency,
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
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
