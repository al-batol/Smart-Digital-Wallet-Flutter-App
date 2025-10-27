import 'package:smart_digital_wallet/src/core/common/mocked_data/accounts_mock.dart'
    show accountsMock;
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/common/services/network_connectivity_service.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/models/accounts_model.dart';

abstract class DashboardRemoteDataScource {
  Future<AccountsModel> getAccounts();
}

class DashboardRemoteDataScourceImp implements DashboardRemoteDataScource {
  final ApiClientService apiClientService;
  final NetworkConnectivityService networkConnectivityService;

  DashboardRemoteDataScourceImp({
    required this.apiClientService,
    required this.networkConnectivityService,
  });

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
