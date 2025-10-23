import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/payment_entity.dart';

part 'payment_model.g.dart';

@HiveType(typeId: 3)
class PaymentModel extends TransactionModel {
  const PaymentModel({
    required super.billType,
    required super.billNumber,
    required super.amount,
    required super.currency,
    required super.accountId,
  }) : super(type: 'paybill');

  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      billType: entity.billType,
      billNumber: entity.billNumber,
      amount: entity.amount,
      currency: entity.currency,
      accountId: entity.accountId,
    );
  }

  PaymentEntity toEntity() {
    return PaymentEntity(
      billType: billType!,
      billNumber: billNumber!,
      amount: amount!,
      currency: currency!,
      accountId: accountId!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'billType': billType,
      'billNumber': billNumber,
      'amount': amount,
      'currency': currency,
      'accountId': accountId,
    };
  }
}
