import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/usecases/top_up_usecase.dart';

part 'top_up_event.dart';
part 'top_up_state.dart';

class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  final TopUpUsecase topUpUsecase;

  TopUpBloc({required this.topUpUsecase}) : super(const TopUpState()) {
    on<SelectAccountEvent>(_onSelectAccountEventHandler);
    on<SelectAmountEvent>(_onSelectAmountEventHandler);
    on<SelectCurrencyEvent>(_onSelectCurrencyEventHandler);
    on<ConfirmTopUpEvent>(_onConfirmTopUpEventHandler);
  }

  void _onSelectAccountEventHandler(
    SelectAccountEvent event,
    Emitter<TopUpState> emit,
  ) {
    emit(
      state.copyWith(selectedAccount: event.account, selectedCurrencyIndex: 0),
    );
  }

  void _onSelectCurrencyEventHandler(
    SelectCurrencyEvent event,
    Emitter<TopUpState> emit,
  ) {
    emit(state.copyWith(selectedCurrencyIndex: event.currencyIndex));
  }

  void _onSelectAmountEventHandler(
    SelectAmountEvent event,
    Emitter<TopUpState> emit,
  ) {
    emit(state.copyWith(selectedAmount: event.amount));
  }

  Future<void> _onConfirmTopUpEventHandler(
    ConfirmTopUpEvent event,
    Emitter<TopUpState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await topUpUsecase(
      amount: event.amount,
      currency: event.currency,
      accountId: event.accountId,
    );
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
