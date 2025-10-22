import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/services/api_client_service.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/models/payment_model.dart';

abstract class PayBillRemoteDataSource {
  Future<void> payBill(PaymentModel payment);
}

class PayBillRemoteDataSourceImp implements PayBillRemoteDataSource {
  final ApiClientService apiClientService;

  PayBillRemoteDataSourceImp({required this.apiClientService});

  @override
  Future<void> payBill(PaymentModel payment) async {
    try {
      await apiClientService.post('https://api.com/pay-bill', payment.toJson());
    } catch (e) {
      throw PayBillException(message: e.toString());
    }
  }
}
