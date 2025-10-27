import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/provider_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/usecases/top_up_usecase.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  final TopUpUsecase topUpUsecase;

  TopUpBloc({required this.topUpUsecase}) : super(const TopUpState()) {
    on<SelectProviderEvent>(_onSelectProviderEventHandler);
    on<ConfirmTopUpEvent>(_onConfirmTopUpEventHandler);
  }

  void _onSelectProviderEventHandler(
    SelectProviderEvent event,
    Emitter<TopUpState> emit,
  ) {
    emit(state.copyWith(selectedProvider: event.provider));
  }

  Future<void> _onConfirmTopUpEventHandler(
    ConfirmTopUpEvent event,
    Emitter<TopUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final topUp = TopUpEntity(
      provider: event.provider,
      number: event.number,
      amount: event.amount,
      currency: event.currency,
      accountId: event.accountId,
    );

    final result = await topUpUsecase(topUp);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: failure.message,
            isSuccess: false,
          ),
        );
      },
      (topUp) {
        emit(
          state.copyWith(
            isLoading: false,
            topUpResult: topUp,
            errorMessage: '',
            isSuccess: true,
          ),
        );
      },
    );
  }
}
