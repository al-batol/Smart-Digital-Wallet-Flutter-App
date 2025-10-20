import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/currency_balance_entity.dart';

class AccountEntity extends Equatable {
  final String id;
  final AccountType type;
  final List<CurrencyBalanceEntity>? currencyBalances;

  const AccountEntity({
    required this.id,
    required this.type,
    this.currencyBalances,
  });

  @override
  List<Object?> get props => [id, type, currencyBalances];
}
