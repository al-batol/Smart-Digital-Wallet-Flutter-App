import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';

part 'top_up_model.g.dart';

@HiveType(typeId: 1)
class TopUpModel extends TransactionModel {
  const TopUpModel({
    required super.amount,
    required super.currency,
    required super.accountId,
  }) : super(type: 'topup');

  factory TopUpModel.fromJson(Map<String, dynamic> json) {
    return TopUpModel(
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      accountId: json['accountId'] as String,
    );
  }

  factory TopUpModel.fromEntity(TopUpEntity entity) {
    return TopUpModel(
      amount: entity.amount,
      currency: entity.currency,
      accountId: entity.accountId,
    );
  }

  TopUpEntity toEntity() {
    return TopUpEntity(
      amount: amount!,
      currency: currency!,
      accountId: accountId!,
    );
  }
}
