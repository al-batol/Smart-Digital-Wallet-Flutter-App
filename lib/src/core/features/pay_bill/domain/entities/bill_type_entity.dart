import 'package:equatable/equatable.dart';

class BillTypeEntity extends Equatable {
  final int id;
  final String billType;

  const BillTypeEntity({required this.id, required this.billType});

  @override
  List<Object?> get props => [id, billType];
}
