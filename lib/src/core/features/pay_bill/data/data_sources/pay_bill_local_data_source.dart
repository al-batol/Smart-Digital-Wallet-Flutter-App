import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/pay_bill/data/models/payment_model.dart';

abstract class PayBillLocalDataSource {
  Future<void> cachePayment(PaymentModel payment);
}

class PayBillLocalDataSourceImp implements PayBillLocalDataSource {
  @override
  Future<void> cachePayment(PaymentModel payment) async {
    final box = await Hive.openBox<TransactionModel>('transactions');
    await box.add(payment);
  }
}
