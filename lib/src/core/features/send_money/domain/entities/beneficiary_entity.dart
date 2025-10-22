import 'package:equatable/equatable.dart';

class BeneficiaryEntity extends Equatable {
  final String id;
  final String name;
  final String accountNumber;

  const BeneficiaryEntity({
    required this.id,
    required this.name,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [id, name, accountNumber];
}
