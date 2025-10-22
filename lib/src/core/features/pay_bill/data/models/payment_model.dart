import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.billId,
    required super.billType,
    required super.amount,
    required super.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'billId': billId,
      'billType': billType,
      'amount': amount,
      'accountId': accountId,
    };
  }
}
