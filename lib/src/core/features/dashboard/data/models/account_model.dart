import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({super.id, super.type, super.currency, super.balance});

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      type: AccountType.fromName(json['type']),
      currency: AccountCurrency.fromName(json['currency']),
      balance: json['balance'],
    );
  }

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      type: type,
      currency: currency,
      balance: balance,
    );
  }
}
