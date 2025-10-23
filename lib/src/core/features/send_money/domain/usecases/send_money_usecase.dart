import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/transfer_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/repository/send_money_repository.dart';

class SendMoneyUsecase {
  final SendMoneyRepository sendMoneyRepository;

  SendMoneyUsecase({required this.sendMoneyRepository});

  ResultVoidWithMessage call(TransferEntity transfer) async {
    return await sendMoneyRepository.sendMoney(transfer);
  }
}
