import 'package:equatable/equatable.dart';
import 'package:smart_digital_wallet/src/core/features/dashboard/domain/entities/account_entity.dart';

class AccountsEntity extends Equatable {
  final String id;
  final List<AccountEntity> accounts;
  final double loyaltyPoints;

  const AccountsEntity({
    required this.id,
    required this.accounts,
    required this.loyaltyPoints,
  });

  @override
  List<Object?> get props => [id, accounts, loyaltyPoints];
}
