import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/entities/beneficiary_entity.dart';
import 'package:smart_digital_wallet/src/core/features/send_money/domain/repository/send_money_repository.dart';

class GetBeneficiariesUsecase {
  final SendMoneyRepository sendMoneyRepository;

  GetBeneficiariesUsecase({required this.sendMoneyRepository});

  ResultFuture<List<BeneficiaryEntity>> call() async {
    return await sendMoneyRepository.getBeneficiaries();
  }
}
