import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.billType,
    required super.amount,
    required super.currency,
    required super.accountId,
  });

  Map<String, dynamic> toJson() {
    return {
      'billType': billType,
      'amount': amount,
      'currency': currency,
      'accountId': accountId,
    };
  }
}
