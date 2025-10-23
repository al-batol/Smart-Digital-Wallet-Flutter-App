import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/repository/pay_bill_repository.dart';

class PayBillUsecase {
  final PayBillRepository payBillRepository;

  PayBillUsecase({required this.payBillRepository});

  ResultVoidWithMessage call(PaymentEntity payment) async {
    return await payBillRepository.payBill(payment);
  }
}
