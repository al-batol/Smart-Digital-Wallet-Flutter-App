import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/common/helper/typedef.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/repository/dashbaord_repository.dart';

class CurrencyExchangeUsecase {
  final DashbaordRepository dashbaordRepository;

  CurrencyExchangeUsecase({required this.dashbaordRepository});

  ResultVoidWithMessage call({
    required AccountCurrency fromCurrency,
    required AccountCurrency toCurrency,
    required double amount,
  }) async {
    return await dashbaordRepository.currencyExchange(
      fromCurrency: fromCurrency,
      toCurrency: toCurrency,
      amount: amount,
    );
  }
}
