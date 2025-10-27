import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_digital_wallet/src/core/common/constants/app_strings.dart';
import 'package:smart_digital_wallet/src/core/common/localization/localization_service.dart';
import 'package:smart_digital_wallet/src/core/common/mocked_data/providers_mock.dart';
import 'package:smart_digital_wallet/src/core/common/widgets/dropdown_selector_widget.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/models/provider_model.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/provider_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/presentation/blocs/bloc/top_up_bloc.dart';

class ProviderSelectorWidget extends StatelessWidget {
  const ProviderSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = providersMock
        .map((json) => ProviderModel.fromJson(json))
        .toList()
        .cast<ProviderEntity>();

    return BlocBuilder<TopUpBloc, TopUpState>(
      buildWhen: (previous, current) =>
          previous.selectedProvider != current.selectedProvider,
      builder: (context, state) {
        return DropdownSelectorWidget<ProviderEntity>(
          title: context.translate(selectProvider),
          subtitle: context.translate(chooseProvider),
          selectedValue: state.selectedProvider ?? providers.first,
          items: providers,
          displayText: (provider) => context.translate(provider.provider),
          onChanged: (ProviderEntity? newProvider) {
            if (newProvider != null) {
              context.read<TopUpBloc>().add(
                SelectProviderEvent(provider: newProvider),
              );
            }
          },
        );
      },
    );
  }
}
