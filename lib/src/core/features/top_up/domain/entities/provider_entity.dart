import 'package:equatable/equatable.dart';

class ProviderEntity extends Equatable {
  final int id;
  final String provider;

  const ProviderEntity({required this.id, required this.provider});

  @override
  List<Object?> get props => [id, provider];
}
