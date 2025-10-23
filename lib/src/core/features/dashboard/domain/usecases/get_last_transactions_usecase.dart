import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';

class GetLastTransactionsUsecase {
  final DashbaordRepository repository;

  GetLastTransactionsUsecase({required this.repository});

  ResultFuture<List<TransactionModel>> call({int limit = 5}) async {
    return await repository.getLastTransactions(limit: limit);
  }
}
