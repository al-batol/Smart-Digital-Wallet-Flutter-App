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
import 'package:smart_digital_wallet/src/core/common/mocked_data/providers_mock.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/amount_input_widget.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/app_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/number_input_widget.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/models/provider_model.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/widgets/top_up/provider_selector_widget.dart';

class TopUpView extends StatefulWidget {
  final List<AccountEntity> accounts;

  const TopUpView({super.key, required this.accounts});

  @override
  State<TopUpView> createState() => _TopUpViewState();
}

class _TopUpViewState extends State<TopUpView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _amountController;
  late final TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _amountController = TextEditingController();
    _numberController = TextEditingController();
    final firstProvider = ProviderModel.fromJson(providersMock.first);
    context.read<TopUpBloc>().add(SelectProviderEvent(provider: firstProvider));
  }

  @override
  void dispose() {
    _amountController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgetXl(
          text: context.translate(topUp),
          textColor: textHeadlineColor,
        ),
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
                failureSnackBar(
                  title: context.translate(error),
                  message: context.translate(state.errorMessage),
                ),
              );
          }
          if (state.isSuccess && state.topUpResult != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                successSnackBar(
                  title: context.translate(success),
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
                child: BlocBuilder<TopUpBloc, TopUpState>(
                  builder: (context, state) {
                    final defaultAccount = widget.accounts.first;
                    final defaultCurrency =
                        defaultAccount.currencyBalances!.first;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ProviderSelectorWidget(),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        NumberInputWidget(
                          controller: _numberController,
                          label: phoneNumber,
                          hintText: enterPhoneNumberPlaceholder,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return context.translate(enterPhoneNumber);
                            }
                            if (value.length < 9) {
                              return context.translate(validPhoneNumber);
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: AppDimensions.spacingMd.height(context),
                        ),
                        AmountInputWidget(
                          amountController: _amountController,
                          maxAmount: defaultCurrency.balance,
                          currency: defaultCurrency.currency.currency,
                        ),
                        SizedBox(
                          height: AppDimensions.spacingXl.height(context),
                        ),
                        AppButton(
                          text: context.translate(confirmTopUp),
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                state.selectedProvider != null) {
                              context.read<TopUpBloc>().add(
                                ConfirmTopUpEvent(
                                  provider: state.selectedProvider!.provider,
                                  number: _numberController.text,
                                  amount: double.parse(_amountController.text),
                                  currency: defaultCurrency.currency.currency,
                                  accountId: widget.accounts.first.id,
                                ),
                              );
                            }
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
