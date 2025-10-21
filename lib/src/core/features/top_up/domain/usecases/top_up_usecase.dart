import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/repository/top_up_repository.dart';

class TopUpUsecase {
  final TopUpRepository topUpRepository;

  TopUpUsecase({required this.topUpRepository});

  Future<Result<Success>> call({
    required double amount,
    required String currency,
    required String accountId,
  }) async {
    return await topUpRepository.topUp(
      amount: amount,
      currency: currency,
      accountId: accountId,
    );
  }
}
