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
import 'package:smart_digital_wallet/src/core/common/mocked_data/bill_types_mock.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/amount_input_widget.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/app_button.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/number_input_widget.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/text_widget_xl.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/models/bill_type_model.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/presentation/blocs/bloc/pay_bill_bloc.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/presentation/widgets/pay_bill/bill_type_selector_widget.dart';

class PayBillView extends StatefulWidget {
  final List<AccountEntity> accounts;

  const PayBillView({super.key, required this.accounts});

  @override
  State<PayBillView> createState() => _PayBillViewState();
}

class _PayBillViewState extends State<PayBillView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _amountController;
  late final TextEditingController _numberController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _amountController = TextEditingController();
    _numberController = TextEditingController();
    final firstBillType = BillTypeModel.fromJson(billTypesMock.first);
    context.read<PayBillBloc>().add(
      SelectBillTypeEvent(billType: firstBillType),
    );
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
          text: context.translate(payBill),
          textColor: textHeadlineColor,
        ),
        backgroundColor: primaryColor.withValues(alpha: 0.15),
      ),
      body: BlocListener<PayBillBloc, PayBillState>(
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
          if (state.isSuccess && state.paymentResult != null) {
            if (context.canPop()) {
              context.pop();
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  successSnackBar(
                    title: context.translate(success),
                    message: state.paymentResult!.message,
                  ),
                );
            }
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: ResponsiveHelper.screenWidth(context),
                  padding: EdgeInsets.all(
                    AppDimensions.paddingLg.width(context),
                  ),
                  child: Form(
                    key: _formKey,
                    child: BlocBuilder<PayBillBloc, PayBillState>(
                      builder: (context, state) {
                        final defaultAccount = widget.accounts.first;
                        final defaultCurrency =
                            defaultAccount.currencyBalances!.first;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const BillTypeSelectorWidget(),
                            SizedBox(
                              height: AppDimensions.spacingMd.height(context),
                            ),
                            NumberInputWidget(
                              controller: _numberController,
                              label: billNumber,
                              hintText: enterBillNumberPlaceholder,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return context.translate(enterBillNumber);
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
                              text: context.translate(payBill),
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    state.selectedBillType != null) {
                                  context.read<PayBillBloc>().add(
                                    ConfirmPayBillEvent(
                                      billType:
                                          state.selectedBillType!.billType,
                                      number: _numberController.text,
                                      amount: double.parse(
                                        _amountController.text,
                                      ),
                                      currency:
                                          defaultCurrency.currency.currency,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
