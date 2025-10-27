import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/data/data_sources/currency_exchange_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/data/data_sources/currency_exchange_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/data/models/currency_exchange_model.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/entities/currency_exchange_entity.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/domain/repository/currency_exchange_repository.dart';

class CurrencyExchangeRepoImp extends CurrencyExchangeRepository {
  final CurrencyExchangeRemoteDataSource currencyExchangeRemoteDataSource;
  final CurrencyExchangeLocalDataSource currencyExchangeLocalDataSource;

  CurrencyExchangeRepoImp({
    required this.currencyExchangeRemoteDataSource,
    required this.currencyExchangeLocalDataSource,
  });

  @override
  Future<Result<Success>> exchangeCurrency(
    CurrencyExchangeEntity exchange,
  ) async {
    try {
      final exchangeModel = CurrencyExchangeModel.fromEntity(exchange);
      await currencyExchangeRemoteDataSource.exchangeCurrency(exchangeModel);
      await currencyExchangeLocalDataSource.cacheExchange(exchangeModel);
      return Right(
        CurrencyExchangeSuccess(
          message:
              'Successfully exchanged ${exchange.amount} ${exchange.fromCurrency} to ${exchange.convertedAmount.toStringAsFixed(2)} ${exchange.toCurrency}',
        ),
      );
    } on CurrencyExchangeException catch (e) {
      return Left(CurrencyExchangeFailure(message: e.message));
    }
  }
}
