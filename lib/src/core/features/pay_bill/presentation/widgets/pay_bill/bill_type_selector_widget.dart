import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/mocked_data/bill_types_mock.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/models/bill_type_model.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/bill_type_entity.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/presentation/blocs/bloc/pay_bill_bloc.dart';

class BillTypeSelectorWidget extends StatelessWidget {
  const BillTypeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final billTypes = billTypesMock
        .map((json) => BillTypeModel.fromJson(json))
        .toList()
        .cast<BillTypeEntity>();

    return BlocBuilder<PayBillBloc, PayBillState>(
      buildWhen: (previous, current) =>
          previous.selectedBillType != current.selectedBillType,
      builder: (context, state) {
        return DropdownSelectorWidget<BillTypeEntity>(
          title: 'Select Bill Type',
          subtitle: 'Choose the bill you want to pay',
          selectedValue: state.selectedBillType ?? billTypes.first,
          items: billTypes,
          displayText: (billType) => billType.billType,
          onChanged: (BillTypeEntity? newBillType) {
            if (newBillType != null) {
              context.read<PayBillBloc>().add(
                SelectBillTypeEvent(billType: newBillType),
              );
            }
          },
        );
      },
    );
  }
}
