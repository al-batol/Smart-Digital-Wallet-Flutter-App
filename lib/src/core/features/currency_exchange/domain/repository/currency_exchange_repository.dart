import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/entities/currency_exchange_entity.dart';

abstract class CurrencyExchangeRepository {
  ResultVoidWithMessage exchangeCurrency(CurrencyExchangeEntity exchange);
}
