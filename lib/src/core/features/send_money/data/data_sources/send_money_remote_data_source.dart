import 'package:smart_digital_wallet/src/core/common/mocked_data/beneficiaries_mock.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/models/beneficiary_model.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/models/transfer_model.dart';

abstract class SendMoneyRemoteDataSource {
  Future<List<BeneficiaryModel>> getBeneficiaries();

  Future<void> sendMoney(TransferModel transfer);
}

class SendMoneyRemoteDataSourceImp implements SendMoneyRemoteDataSource {
  final ApiClientService apiClientService;

  SendMoneyRemoteDataSourceImp({required this.apiClientService});

  @override
  Future<List<BeneficiaryModel>> getBeneficiaries() async {
    try {
      await apiClientService.get('https://api.com/beneficiaries');

      return beneficiariesMock
          .map((json) => BeneficiaryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw SendMoneyException(message: e.toString());
    }
  }

  @override
  Future<void> sendMoney(TransferModel transfer) async {
    try {
      await apiClientService.post(
        'https://api.com/send-money',
        transfer.toJson(),
      );
    } catch (e) {
      throw SendMoneyException(message: e.toString());
    }
  }
}
