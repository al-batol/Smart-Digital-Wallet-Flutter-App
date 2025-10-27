import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/models/top_up_model.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';

abstract class TopUpRemoteDataSource {
  Future<TopUpModel> topUp(TopUpEntity topUp);
}

class TopUpRemoteDataSourceImp implements TopUpRemoteDataSource {
  final ApiClientService apiClientService;
  final NetworkConnectivityService networkConnectivityService;

  TopUpRemoteDataSourceImp({
    required this.apiClientService,
    required this.networkConnectivityService,
  });

  @override
  Future<TopUpModel> topUp(TopUpEntity topUp) async {
    try {
      await networkConnectivityService.checkConnection(
        TopUpException(message: 'check_internet_connection'),
      );

      final topUpModel = TopUpModel.fromEntity(topUp);

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
