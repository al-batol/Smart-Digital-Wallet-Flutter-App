import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/accounts_entity.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';

class GetAccountsUsecase {
  final DashbaordRepository dashbaordRepository;

  GetAccountsUsecase({required this.dashbaordRepository});

  Future<Result<AccountsEntity>> call() async {
    return await dashbaordRepository.getAccounts();
  }
}
