import 'package:smart_digital_wallet/src/core/features/dashboard/data/models/account_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/accounts_entity.dart';

class AccountsModel extends AccountsEntity {
  const AccountsModel({
    required super.id,
    required super.accounts,
    required super.loyaltyPoints,
  });

  factory AccountsModel.fromJson(Map<String, dynamic> json) {
    final accountsList = (json['accounts'] as List<dynamic>)
        .map(
          (accountJson) =>
              AccountModel.fromJson(accountJson as Map<String, dynamic>),
        )
        .toList();

    final loyaltyPoints = (json['loyalty_points'] as num).toDouble();

    return AccountsModel(
      id: json['id'] as String,
      accounts: accountsList,
      loyaltyPoints: loyaltyPoints,
    );
  }

  AccountsEntity toEntity() {
    return AccountsEntity(
      id: id,
      accounts: accounts,
      loyaltyPoints: loyaltyPoints,
    );
  }
}
