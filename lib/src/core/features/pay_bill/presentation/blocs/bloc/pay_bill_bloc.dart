import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/bill_type_entity.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/usecases/pay_bill_usecase.dart';

part 'pay_bill_event.dart';
part 'pay_bill_state.dart';

class PayBillBloc extends Bloc<PayBillEvent, PayBillState> {
  final PayBillUsecase payBillUsecase;

  PayBillBloc({required this.payBillUsecase}) : super(const PayBillState()) {
    on<SelectBillTypeEvent>(_onSelectBillTypeEventHandler);
    on<ConfirmPayBillEvent>(_onConfirmPayBillEventHandler);
  }

  void _onSelectBillTypeEventHandler(
    SelectBillTypeEvent event,
    Emitter<PayBillState> emit,
  ) {
    emit(state.copyWith(selectedBillType: event.billType));
  }

  Future<void> _onConfirmPayBillEventHandler(
    ConfirmPayBillEvent event,
    Emitter<PayBillState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final payment = PaymentEntity(
      billType: event.billType,
      billNumber: event.billNumber,
      amount: event.amount,
      currency: event.currency,
      accountId: event.accountId,
    );

    final result = await payBillUsecase(payment);
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
      (success) {
        emit(
          state.copyWith(
            isLoading: false,
            paymentResult: success,
            errorMessage: '',
            isSuccess: true,
          ),
        );
      },
    );
  }
}
