import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/data_sources/top_up_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/data_sources/top_up_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/repository/top_up_repository.dart';

class TopUpRepoImp extends TopUpRepository {
  final TopUpRemoteDataSource topUpRemoteDataSource;
  final TopUpLocalDataSource topUpLocalDataSource;

  TopUpRepoImp({
    required this.topUpRemoteDataSource,
    required this.topUpLocalDataSource,
  });

  @override
  Future<Result<Success>> topUp({
    required double amount,
    required String currency,
    required String accountId,
  }) async {
    try {
      final topUp = await topUpRemoteDataSource.topUp(
        amount: amount,
        currency: currency,
        accountId: accountId,
      );
      await topUpLocalDataSource.cacheTopUp(topUp);
      return Right(
        TopUpSuccess(
          message: 'Top up of $amount $currency completed successfully',
        ),
      );
    } on TopUpException catch (e) {
      return left(TopUpFailure(message: e.message));
    }
  }
}
