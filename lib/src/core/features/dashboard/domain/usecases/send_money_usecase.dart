import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';

class SendMoneyUsecase {
  final DashbaordRepository dashbaordRepository;

  SendMoneyUsecase({required this.dashbaordRepository});

  ResultVoidWithMessage call({
    required String receiverId,
    required double amount,
  }) async {
    return await dashbaordRepository.sendMoney(
      receiverId: receiverId,
      amount: amount,
    );
  }
}
