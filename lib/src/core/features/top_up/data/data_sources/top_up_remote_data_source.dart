import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/models/top_up_model.dart';

abstract class TopUpRemoteDataSource {
  Future<TopUpModel> topUp({
    required double amount,
    required String currency,
    required String accountId,
  });
}

class TopUpRemoteDataSourceImp implements TopUpRemoteDataSource {
  final ApiClientService apiClientService;

  TopUpRemoteDataSourceImp({required this.apiClientService});

  @override
  Future<TopUpModel> topUp({
    required double amount,
    required String currency,
    required String accountId,
  }) async {
    try {
      await apiClientService.post('https://api.com/top-up', {
        'amount': amount,
        'currency': currency,
        'accountId': accountId,
      });

      return TopUpModel(
        amount: amount,
        currency: currency,
        accountId: accountId,
      );
    } catch (e) {
      throw TopUpException(message: e.toString());
    }
  }
}
