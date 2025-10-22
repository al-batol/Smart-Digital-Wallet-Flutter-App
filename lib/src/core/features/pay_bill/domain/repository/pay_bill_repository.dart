import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';

abstract class PayBillRepository {
  ResultVoidWithMessage payBill(PaymentEntity payment);
}
