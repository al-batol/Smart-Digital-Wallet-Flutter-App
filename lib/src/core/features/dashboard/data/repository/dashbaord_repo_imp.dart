import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/data_sources/dashboard_remote_data_scource.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/data/models/account_model.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';

class DashbaordRepoImp implements DashbaordRepository {
  final DashboardRemoteDataScource dashbaordRemoteDataSource;

  DashbaordRepoImp({required this.dashbaordRemoteDataSource});

  @override
  ResultFuture<List<AccountEntity>> getAccounts() async {
    try {
      final List<AccountModel> models = await dashbaordRemoteDataSource
          .getAccounts();
      final List<AccountEntity> entities = models
          .map((e) => e.toEntity())
          .toList();
      return right(entities);
    } on DashboardException catch (e) {
      return left(DashboardFailure(message: e.message));
    }
  }

  @override
  ResultVoidWithMessage currencyExchange({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  }) async {
    try {
      await dashbaordRemoteDataSource.currencyExchange(
        fromCurrency: fromCurrency,
        toCurrency: toCurrency,
        amount: amount,
      );
      return right(DashboardSuccess(message: "currency_exchange_success"));
    } on DashboardException catch (e) {
      return left(DashboardFailure(message: e.message));
    }
  }

  @override
  ResultVoidWithMessage sendMoney({
    required String receiverId,
    required double amount,
  }) async {
    try {
      await dashbaordRemoteDataSource.sendMoney(
        receiverId: receiverId,
        amount: amount,
      );
      return right(DashboardSuccess(message: "send_money_success"));
    } on DashboardException catch (e) {
      return left(DashboardFailure(message: e.message));
    }
  }
}
