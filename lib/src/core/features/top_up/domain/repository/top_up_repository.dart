import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';

abstract class TopUpRepository {
  Future<Result<Success>> topUp({
    required double amount,
    required String currency,
    required String accountId,
  });
}
