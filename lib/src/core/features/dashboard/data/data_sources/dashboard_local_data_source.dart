import 'package:hive/hive.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';

abstract class DashboardLocalDataSource {
  Future<List<TransactionModel>> getLastTransactions({int limit = 5});
}

class DashboardLocalDataSourceImp implements DashboardLocalDataSource {
  @override
  Future<List<TransactionModel>> getLastTransactions({int limit = 5}) async {
    final box = await Hive.openBox<TransactionModel>('transactions');
    final transactions = box.values.toList();

    if (transactions.isEmpty) return [];

    return transactions.reversed.toList();
  }
}
