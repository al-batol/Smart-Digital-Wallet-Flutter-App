import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _amountController = TextEditingController();
    final firstBillType = BillTypeModel.fromJson(billTypesMock.first);
    context.read<PayBillBloc>().add(
      SelectBillTypeEvent(billType: firstBillType),
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
        title: const TextWidgetXl(
          text: 'Pay Bill',
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
                failureSnackBar(title: 'Error!', message: state.errorMessage),
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
                    title: 'Success!',
                    message: state.paymentResult!.message,
                  ),
                );
            }
          }
        },
        child: SafeArea(
          child: Container(
            width: ResponsiveHelper.screenWidth(context),
            padding: EdgeInsets.all(AppDimensions.paddingLg.width(context)),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BillTypeSelectorWidget(),
                  SizedBox(height: AppDimensions.spacingMd.height(context)),
                  Builder(
                    builder: (context) {
                      double? maxAmount;
                      String? currency;
                      if (widget.accounts.isNotEmpty &&
                          widget.accounts.first.currencyBalances != null &&
                          widget.accounts.first.currencyBalances!.isNotEmpty) {
                        final defaultCurrency =
                            widget.accounts.first.currencyBalances!.first;
                        maxAmount = defaultCurrency.balance;
                        currency = defaultCurrency.currency.currency;
                      }
                      return AmountInputWidget(
                        amountController: _amountController,
                        maxAmount: maxAmount,
                        currency: currency,
                      );
                    },
                  ),
                  const Spacer(),
                  BlocBuilder<PayBillBloc, PayBillState>(
                    buildWhen: (previous, current) =>
                        previous.selectedBillType != current.selectedBillType,
                    builder: (context, state) {
                      return AppButton(
                        text: 'Pay Bill',
                        onPressed: () {
                          if (_formKey.currentState!.validate() &&
                              state.selectedBillType != null &&
                              widget.accounts.isNotEmpty &&
                              widget.accounts.first.currencyBalances != null &&
                              widget
                                  .accounts
                                  .first
                                  .currencyBalances!
                                  .isNotEmpty) {
                            final defaultCurrency =
                                widget.accounts.first.currencyBalances!.first;
                            context.read<PayBillBloc>().add(
                              ConfirmPayBillEvent(
                                billType: state.selectedBillType!.billType,
                                amount: double.parse(_amountController.text),
                                currency: defaultCurrency.currency.currency,
                                accountId: widget.accounts.first.id,
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
    );
  }
}
