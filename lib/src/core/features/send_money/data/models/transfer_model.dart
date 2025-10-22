import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/transfer_entity.dart';

class TransferModel extends TransferEntity {
  const TransferModel({
    required super.recipientAccountId,
    required super.sourceAccountId,
    required super.currency,
    required super.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'recipientAccountId': recipientAccountId,
      'sourceAccountId': sourceAccountId,
      'currency': currency,
      'amount': amount,
    };
  }
}
