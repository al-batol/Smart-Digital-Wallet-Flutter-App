import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';

class CurrencyBalanceEntity extends Equatable {
  final AccountCurrency currency;
  final double balance;

  const CurrencyBalanceEntity({required this.currency, required this.balance});

  @override
  List<Object?> get props => [currency, balance];
}
