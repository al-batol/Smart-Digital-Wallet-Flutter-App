import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/mocked_data/accounts_mock.dart'
    show accountsMock;
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/models/account_model.dart';

abstract class DashboardRemoteDataScource {
  Future<List<AccountModel>> getAccounts();
  Future<Unit> sendMoney({required String receiverId, required double amount});
  Future<Unit> currencyExchange({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  });
}

class DashboardRemoteDataScourceImp implements DashboardRemoteDataScource {
  final ApiClientService apiClientService;

  DashboardRemoteDataScourceImp({required this.apiClientService});

  @override
  Future<Unit> currencyExchange({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  }) async {
    try {
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
  Future<List<AccountModel>> getAccounts() async {
    try {
      final accounts = await apiClientService.get(
        'https://api.com/dashboard/accounts',
      );
      return accountsMock.map((e) => AccountModel.fromJson(e)).toList();
    } catch (e) {
      throw DashboardException(message: e.toString());
    }
  }

  @override
  Future<Unit> sendMoney({
    required String receiverId,
    required double amount,
  }) async {
    try {
      apiClientService.post('https://api.com/dashboard/send-money', {
        'receiverId': receiverId,
        'amount': amount,
      });
      return unit;
    } catch (e) {
      throw DashboardException(message: e.toString());
    }
  }
}
