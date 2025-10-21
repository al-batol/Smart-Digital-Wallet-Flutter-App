import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';

class TopUpModel extends TopUpEntity {
  const TopUpModel({
    required super.amount,
    required super.currency,
    required super.accountId,
  });

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
}
