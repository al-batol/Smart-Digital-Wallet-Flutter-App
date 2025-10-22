import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/models/transfer_model.dart';

abstract class SendMoneyLocalDataSource {
  Future<void> cacheTransfer(TransferModel transfer);
}

class SendMoneyLocalDataSourceImp implements SendMoneyLocalDataSource {
  @override
  Future<void> cacheTransfer(TransferModel transfer) async {
    final box = await Hive.openBox<TransactionModel>('transactions');
    await box.add(transfer);
  }
}
