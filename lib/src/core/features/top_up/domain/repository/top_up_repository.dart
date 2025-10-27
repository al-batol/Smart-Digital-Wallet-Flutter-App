import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';

abstract class TopUpRepository {
  Future<Result<Success>> topUp(TopUpEntity topUp);
}
