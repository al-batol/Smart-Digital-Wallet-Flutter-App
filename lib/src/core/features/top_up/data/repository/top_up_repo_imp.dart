import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/data_sources/top_up_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/data/data_sources/top_up_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/repository/top_up_repository.dart';

class TopUpRepoImp extends TopUpRepository {
  final TopUpRemoteDataSource topUpRemoteDataSource;
  final TopUpLocalDataSource topUpLocalDataSource;

  TopUpRepoImp({
    required this.topUpRemoteDataSource,
    required this.topUpLocalDataSource,
  });

  @override
  Future<Result<Success>> topUp(TopUpEntity topUp) async {
    try {
      final topUpModel = await topUpRemoteDataSource.topUp(topUp);
      await topUpLocalDataSource.cacheTopUp(topUpModel);
      return Right(
        TopUpSuccess(
          message:
              'Top up of ${topUp.amount} ${topUp.currency} completed successfully',
        ),
      );
    } on TopUpException catch (e) {
      return left(TopUpFailure(message: e.message));
    }
  }
}
