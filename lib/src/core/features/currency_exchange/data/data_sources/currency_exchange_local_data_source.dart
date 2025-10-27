import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/data/models/currency_exchange_model.dart';

abstract class CurrencyExchangeLocalDataSource {
  Future<void> cacheExchange(CurrencyExchangeModel exchange);
}

class CurrencyExchangeLocalDataSourceImp
    implements CurrencyExchangeLocalDataSource {
  CurrencyExchangeLocalDataSourceImp();

  @override
  Future<void> cacheExchange(CurrencyExchangeModel exchange) async {
    final box = await Hive.openBox<TransactionModel>('transactions');
    await box.add(exchange);
  }
}
