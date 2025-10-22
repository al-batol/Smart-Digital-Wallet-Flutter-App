import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/models/top_up_model.dart';

abstract class TopUpLocalDataSource {
  Future<void> cacheTopUp(TopUpModel topUp);
}

class TopUpLocalDataSourceImp implements TopUpLocalDataSource {
  @override
  Future<void> cacheTopUp(TopUpModel topUp) async {
    final box = await Hive.openBox<TransactionModel>('transactions');
    await box.add(topUp);
  }
}
