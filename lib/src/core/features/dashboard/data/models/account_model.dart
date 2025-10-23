import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/models/currency_balance_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';

class AccountModel extends AccountEntity {
  const AccountModel({
    required super.id,
    required super.type,
    super.currencyBalances,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    final type = AccountType.fromName(json['type']);
    // Parse currencies map if present
    List<CurrencyBalanceModel>? currencyBalances;
    if (json['currencies'] != null) {
      final currenciesMap = json['currencies'] as Map<String, dynamic>;
      currencyBalances = currenciesMap.entries
          .map(
            (entry) => CurrencyBalanceModel.fromMapEntry(
              entry.key,
              entry.value as num,
            ),
          )
          .toList();
    }

    return AccountModel(
      id: json['id'] as String,
      type: type,
      currencyBalances: currencyBalances,
    );
  }

  AccountEntity toEntity() {
    return AccountEntity(
      id: id,
      type: type,
      currencyBalances: currencyBalances,
    );
  }
}
