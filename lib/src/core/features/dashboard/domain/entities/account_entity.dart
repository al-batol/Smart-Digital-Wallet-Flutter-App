import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/common/enums/account_enum.dart';

class AccountEntity extends Equatable {
  final String? id;
  final AccountType? type;
  final AccountCurrency? currency;
  final double? balance;

  const AccountEntity({
    required this.id,
    required this.type,
    required this.currency,
    required this.balance,
  });

  @override
  List<Object?> get props => [id, type, currency, balance];
}
