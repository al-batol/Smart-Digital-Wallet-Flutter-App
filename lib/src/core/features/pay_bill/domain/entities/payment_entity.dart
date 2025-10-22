import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:hive/hive.dart';
part 'payment_entity.g.dart';

@HiveType(typeId: 3)
class PaymentEntity extends TransactionModel {
  const PaymentEntity({
    required super.billType,
    required super.amount,
    required super.currency,
    required super.accountId,
  });
}
