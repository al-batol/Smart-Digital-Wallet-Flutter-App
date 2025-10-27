import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';
import 'package:smart_digital_wallet/src/core/features/currency_exchange/data/models/currency_exchange_model.dart';

abstract class CurrencyExchangeRemoteDataSource {
  Future<void> exchangeCurrency(CurrencyExchangeModel exchange);
}

class CurrencyExchangeRemoteDataSourceImp
    implements CurrencyExchangeRemoteDataSource {
  final ApiClientService apiClientService;
  final NetworkConnectivityService networkConnectivityService;

  CurrencyExchangeRemoteDataSourceImp({
    required this.apiClientService,
    required this.networkConnectivityService,
  });

  @override
  Future<void> exchangeCurrency(CurrencyExchangeModel exchange) async {
    try {
      await networkConnectivityService.checkConnection(
        CurrencyExchangeException(message: 'check_internet_connection'),
      );

      await apiClientService.post(
        'https://api.com/currency-exchange',
        exchange.toJson(),
      );
    } catch (e) {
      throw CurrencyExchangeException(message: e.toString());
    }
  }
}
