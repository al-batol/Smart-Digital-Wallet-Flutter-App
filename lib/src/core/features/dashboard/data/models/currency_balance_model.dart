import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/currency_balance_entity.dart';

class CurrencyBalanceModel extends CurrencyBalanceEntity {
  const CurrencyBalanceModel({required super.currency, required super.balance});

  factory CurrencyBalanceModel.fromMapEntry(String currencyCode, num balance) {
    return CurrencyBalanceModel(
      currency: AccountCurrency.fromName(currencyCode),
      balance: balance.toDouble(),
    );
  }

  CurrencyBalanceEntity toEntity() {
    return CurrencyBalanceEntity(currency: currency, balance: balance);
  }
}
