import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:hive/hive.dart';
part 'transfer_entity.g.dart';

@HiveType(typeId: 2)
class TransferEntity extends TransactionModel {
  const TransferEntity({
    required super.recipientAccountId,
    required super.accountId,
    required super.currency,
    required super.amount,
  });
}
