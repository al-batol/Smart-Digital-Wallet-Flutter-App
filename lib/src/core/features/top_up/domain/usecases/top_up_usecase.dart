import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/common/result/sucess.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/top_up_entity.dart';
import 'package:smart_digital_wallet/src/core/features/top_up/domain/repository/top_up_repository.dart';

class TopUpUsecase {
  final TopUpRepository topUpRepository;

  TopUpUsecase({required this.topUpRepository});

  Future<Result<Success>> call(TopUpEntity topUp) async {
    return await topUpRepository.topUp(topUp);
  }
}
