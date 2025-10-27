import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/accounts_entity.dart';

abstract class DashbaordRepository {
  ResultFuture<AccountsEntity> getAccounts();
  ResultFuture<List<TransactionModel>> getLastTransactions({int limit = 5});
}
