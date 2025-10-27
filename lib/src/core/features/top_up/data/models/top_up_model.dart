import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';

part 'top_up_model.g.dart';

@HiveType(typeId: 1)
class TopUpModel extends TransactionModel {
  const TopUpModel({
    required super.provider,
    required super.number,
    required super.amount,
    required super.currency,
    required super.accountId,
  }) : super(type: 'topup');

  factory TopUpModel.fromJson(Map<String, dynamic> json) {
    return TopUpModel(
      provider: json['provider'] as String,
      number: json['number'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      accountId: json['accountId'] as String,
    );
  }

  factory TopUpModel.fromEntity(TopUpEntity entity) {
    return TopUpModel(
      provider: entity.provider,
      number: entity.number,
      amount: entity.amount,
      currency: entity.currency,
      accountId: entity.accountId,
    );
  }

  TopUpEntity toEntity() {
    return TopUpEntity(
      provider: provider!,
      number: number!,
      amount: amount!,
      currency: currency!,
      accountId: accountId!,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'provider': provider,
      'number': number,
      'amount': amount,
      'currency': currency,
      'accountId': accountId,
    };
  }
}
