import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/transfer_entity.dart';

part 'transfer_model.g.dart';

@HiveType(typeId: 2)
class TransferModel extends TransactionModel {
  const TransferModel({
    required super.recipientAccountId,
    required String sourceAccountId,
    required super.currency,
    required super.amount,
  }) : super(accountId: sourceAccountId, type: 'sendmoney');

  factory TransferModel.fromEntity(TransferEntity entity) {
    return TransferModel(
      recipientAccountId: entity.recipientAccountId,
      sourceAccountId: entity.sourceAccountId,
      currency: entity.currency,
      amount: entity.amount,
    );
  }

  TransferEntity toEntity() {
    return TransferEntity(
      recipientAccountId: recipientAccountId!,
      sourceAccountId: accountId!,
      currency: currency!,
      amount: amount!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipientAccountId': recipientAccountId,
      'sourceAccountId': accountId,
      'currency': currency,
      'amount': amount,
    };
  }
}
