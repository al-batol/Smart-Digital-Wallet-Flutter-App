import 'package:flutter/material.dart';
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
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/widgets/top_up/account_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/widgets/top_up/currency_selector_widget.dart';

class TopUpView extends StatefulWidget {
  final List<AccountEntity> accounts;

  const TopUpView({super.key, required this.accounts});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _amountController = TextEditingController();
    context.read<TopUpBloc>().add(
      SelectAccountEvent(account: widget.accounts.first),
    );
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
        title: const TextWidgetXl(text: 'Top Up', textColor: textHeadlineColor),
        backgroundColor: primaryColor.withValues(alpha: 0.15),
      ),
      body: BlocListener<TopUpBloc, TopUpState>(
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
                failureSnackBar(title: 'Error!', message: state.errorMessage),
              );
          }
          if (state.isSuccess && state.topUpResult != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                successSnackBar(
                  title: 'Success!',
                  message: state.topUpResult!.message,
                ),
              );

            if (context.mounted && context.canPop()) {
              context.pop();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AccountSelectorWidget(
                      accounts: widget.accounts,
                      selectedAccount: widget.accounts.first,
                    ),
                    SizedBox(height: AppDimensions.spacingMd.height(context)),
                    BlocBuilder<TopUpBloc, TopUpState>(
                      buildWhen: (previous, current) =>
                          previous.selectedAccount != current.selectedAccount,
                      builder: (context, state) {
                        return CurrencySelectorWidget(
                          selectedAccount: state.selectedAccount,
                        );
                      },
                    ),
                    SizedBox(height: AppDimensions.spacingMd.height(context)),
                    AmountInputWidget(amountController: _amountController),
                    SizedBox(height: AppDimensions.spacingXl.height(context)),
                    BlocBuilder<TopUpBloc, TopUpState>(
                      buildWhen: (previous, current) =>
                          previous.selectedAccount != current.selectedAccount ||
                          previous.selectedCurrencyIndex !=
                              current.selectedCurrencyIndex,
                      builder: (context, state) {
                        return AppButton(
                          text: 'Confirm Top Up',
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                state.selectedAccount != null) {
                              final selectedCurrency =
                                  state.selectedAccount!.currencyBalances![state
                                      .selectedCurrencyIndex];
                              context.read<TopUpBloc>().add(
                                ConfirmTopUpEvent(
                                  amount: double.parse(_amountController.text),
                                  currency: selectedCurrency.currency.currency,
                                  accountId: state.selectedAccount!.id,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: AppDimensions.spacingMd.height(context)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
