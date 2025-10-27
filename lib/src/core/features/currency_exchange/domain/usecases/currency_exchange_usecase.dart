import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/entities/currency_exchange_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/repository/currency_exchange_repository.dart';

class CurrencyExchangeUsecase {
  final CurrencyExchangeRepository currencyExchangeRepository;

  CurrencyExchangeUsecase({required this.currencyExchangeRepository});

  ResultVoidWithMessage call(CurrencyExchangeEntity exchange) async {
    return await currencyExchangeRepository.exchangeCurrency(exchange);
  }
}
