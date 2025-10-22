import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/beneficiary_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/transfer_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/usecases/get_beneficiaries_usecase.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/usecases/send_money_usecase.dart';

part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final SendMoneyUsecase sendMoneyUsecase;
  final GetBeneficiariesUsecase getBeneficiariesUsecase;

  SendMoneyBloc({
    required this.sendMoneyUsecase,
    required this.getBeneficiariesUsecase,
  }) : super(const SendMoneyState()) {
    on<GetBeneficiariesEvent>(_onGetBeneficiariesEventHandler);
    on<SelectAccountEvent>(_onSelectAccountEventHandler);
    on<SelectBeneficiaryEvent>(_onSelectBeneficiaryEventHandler);
    on<SelectCurrencyEvent>(_onSelectCurrencyEventHandler);
    on<ToggleRecipientModeEvent>(_onToggleRecipientModeEventHandler);
    on<ConfirmSendMoneyEvent>(_onConfirmSendMoneyEventHandler);
  }

  Future<void> _onGetBeneficiariesEventHandler(
    GetBeneficiariesEvent event,
    Emitter<SendMoneyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));
    final result = await getBeneficiariesUsecase();
    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (beneficiaries) {
        emit(
          state.copyWith(
            isLoading: false,
            beneficiaries: beneficiaries,
            selectedBeneficiary: beneficiaries.isNotEmpty
                ? beneficiaries.first
                : null,
          ),
        );
      },
    );
  }

  void _onSelectAccountEventHandler(
    SelectAccountEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(
      state.copyWith(selectedAccount: event.account, selectedCurrencyIndex: 0),
    );
  }

  void _onSelectBeneficiaryEventHandler(
    SelectBeneficiaryEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(selectedBeneficiary: event.beneficiary));
  }

  void _onSelectCurrencyEventHandler(
    SelectCurrencyEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(selectedCurrencyIndex: event.currencyIndex));
  }

  void _onToggleRecipientModeEventHandler(
    ToggleRecipientModeEvent event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(useBeneficiary: event.useBeneficiary));
  }

  Future<void> _onConfirmSendMoneyEventHandler(
    ConfirmSendMoneyEvent event,
    Emitter<SendMoneyState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final transfer = TransferEntity(
      recipientAccountId: event.recipientAccountId,
      accountId: event.sourceAccountId,
      currency: event.currency,
      amount: event.amount,
    );

    final result = await sendMoneyUsecase(transfer);
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
      (sendMoney) {
        emit(
          state.copyWith(
            isLoading: false,
            sendMoneyResult: sendMoney,
            errorMessage: '',
            isSuccess: true,
          ),
        );
      },
    );
  }
}
