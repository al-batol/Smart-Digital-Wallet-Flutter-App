import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/accounts_entity.dart';

abstract class DashbaordRepository {
  ResultFuture<AccountsEntity> getAccounts();
  ResultVoidWithMessage sendMoney({
    required String receiverId,
    required double amount,
  });
  ResultVoidWithMessage currencyExchange({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  });
}
