import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/beneficiary_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/transfer_entity.dart';

abstract class SendMoneyRepository {
  ResultFuture<List<BeneficiaryEntity>> getBeneficiaries();

  ResultVoidWithMessage sendMoney(TransferEntity transfer);
}
