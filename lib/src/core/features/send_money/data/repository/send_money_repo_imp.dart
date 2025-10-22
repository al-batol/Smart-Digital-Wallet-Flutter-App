import 'package:dartz/dartz.dart';
import 'package:smart_digital_wallet/src/core/common/result/exceptions.dart';
import 'package:smart_digital_wallet/src/core/common/result/failure.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/data_sources/send_money_local_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/data_sources/send_money_remote_data_source.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/data/models/transfer_model.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/beneficiary_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/transfer_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/repository/send_money_repository.dart';

class SendMoneyRepoImp extends SendMoneyRepository {
  final SendMoneyRemoteDataSource sendMoneyRemoteDataSource;
  final SendMoneyLocalDataSource sendMoneyLocalDataSource;

  SendMoneyRepoImp({
    required this.sendMoneyRemoteDataSource,
    required this.sendMoneyLocalDataSource,
  });

  @override
  Future<Result<List<BeneficiaryEntity>>> getBeneficiaries() async {
    try {
      final beneficiaries = await sendMoneyRemoteDataSource.getBeneficiaries();
      return Right(beneficiaries);
    } on SendMoneyException catch (e) {
      return Left(SendMoneyFailure(message: e.message));
    }
  }

  @override
  Future<Result<Success>> sendMoney(TransferEntity transfer) async {
    try {
      final transferModel = TransferModel.fromEntity(transfer);
      await sendMoneyRemoteDataSource.sendMoney(transferModel);
      await sendMoneyLocalDataSource.cacheTransfer(transferModel);
      return Right(
        SendMoneySuccess(
          message: 'Successfully sent ${transfer.amount} ${transfer.currency}',
        ),
      );
    } on SendMoneyException catch (e) {
      return Left(SendMoneyFailure(message: e.message));
    }
  }
}
