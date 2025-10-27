import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/models/transaction_model.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/data_sources/dashboard_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/data_sources/dashboard_remote_data_scource.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/accounts_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';

class DashbaordRepoImp implements DashbaordRepository {
  final DashboardRemoteDataScource dashbaordRemoteDataSource;
  final DashboardLocalDataSource dashboardLocalDataSource;

  DashbaordRepoImp({
    required this.dashbaordRemoteDataSource,
    required this.dashboardLocalDataSource,
  });

  @override
  ResultFuture<AccountsEntity> getAccounts() async {
    try {
      final model = await dashbaordRemoteDataSource.getAccounts();
      final entity = model.toEntity();
      return right(entity);
    } on DashboardException catch (e) {
      return left(DashboardFailure(message: e.message));
    }
  }

  @override
  ResultFuture<List<TransactionModel>> getLastTransactions({
    int limit = 5,
  }) async {
    try {
      final transactions = await dashboardLocalDataSource.getLastTransactions(
        limit: limit,
      );
      return right(transactions);
    } on DashboardException catch (e) {
      return left(DashboardFailure(message: e.message));
    }
  }
}
