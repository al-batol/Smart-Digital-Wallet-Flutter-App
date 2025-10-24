import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/mocked_data/accounts_mock.dart'
    show accountsMock;
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/models/accounts_model.dart';

abstract class DashboardRemoteDataScource {
  Future<AccountsModel> getAccounts();
  Future<Unit> currencyExchange({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  });
}

class DashboardRemoteDataScourceImp implements DashboardRemoteDataScource {
  final ApiClientService apiClientService;
  final NetworkConnectivityService networkConnectivityService;

  DashboardRemoteDataScourceImp({
    required this.apiClientService,
    required this.networkConnectivityService,
  });

  @override
  Future<Unit> currencyExchange({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  }) async {
    try {
      await networkConnectivityService.checkConnection(
        DashboardException(message: 'check_internet_connection'),
      );

      apiClientService.post('https://api.com/dashboard/currency-exchange', {
        'fromCurrency': fromCurrency.currency,
        'toCurrency': toCurrency.currency,
        'amount': amount,
      });
      return unit;
    } catch (e) {
      throw DashboardException(message: e.toString());
    }
  }

  @override
  Future<AccountsModel> getAccounts() async {
    try {
      await networkConnectivityService.checkConnection(
        DashboardException(message: 'check_internet_connection'),
      );

      await apiClientService.get('https://api.com/dashboard/accounts');
      return AccountsModel.fromJson(accountsMock);
    } catch (e) {
      throw DashboardException(message: e.toString());
    }
  }
}
