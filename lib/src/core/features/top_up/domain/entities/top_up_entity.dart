import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:hive/hive.dart';
part 'top_up_entity.g.dart';

@HiveType(typeId: 1)
class TopUpEntity extends TransactionModel {
  const TopUpEntity({
    required super.amount,
    required super.currency,
    required super.accountId,
  });
}
