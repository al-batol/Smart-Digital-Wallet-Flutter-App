import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';
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
  final NetworkConnectivityService networkConnectivityService;

  TopUpRemoteDataSourceImp({
    required this.apiClientService,
    required this.networkConnectivityService,
  });

  @override
  Future<TopUpModel> topUp({
    required double amount,
    required String currency,
    required String accountId,
  }) async {
    try {
      await networkConnectivityService.checkConnection(
        TopUpException(message: 'check_internet_connection'),
      );

      final topUpModel = TopUpModel(
        amount: amount,
        currency: currency,
        accountId: accountId,
      );

      await apiClientService.post(
        'https://api.com/top-up',
        topUpModel.toJson(),
      );

      return topUpModel;
    } catch (e) {
      throw TopUpException(message: e.toString());
    }
  }
}
