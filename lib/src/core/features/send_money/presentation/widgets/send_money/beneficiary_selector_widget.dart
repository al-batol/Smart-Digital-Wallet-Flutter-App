import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/helper/format_helper.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/beneficiary_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/presentation/blocs/bloc/send_money_bloc.dart';

class BeneficiarySelectorWidget extends StatelessWidget {
  final List<BeneficiaryEntity> beneficiaries;

  const BeneficiarySelectorWidget({super.key, required this.beneficiaries});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(
      buildWhen: (previous, current) =>
          previous.selectedBeneficiary != current.selectedBeneficiary,
      builder: (context, state) {
        return DropdownSelectorWidget<BeneficiaryEntity>(
          title: 'Select Beneficiary',
          subtitle: 'Choose who to send money to',
          selectedValue: state.selectedBeneficiary,
          items: beneficiaries,
          displayText: (beneficiary) => FormatHelper.formatAccountDisplay(
            beneficiary.name,
            beneficiary.accountNumber,
          ),
          onChanged: (beneficiary) {
            if (beneficiary != null) {
              context.read<SendMoneyBloc>().add(
                SelectBeneficiaryEvent(beneficiary: beneficiary),
              );
            }
          },
        );
      },
    );
  }
}
