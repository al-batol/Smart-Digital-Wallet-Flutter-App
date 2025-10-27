import 'package:smart_digital_wallet/src/core/features/top_up/domain/entities/provider_entity.dart';

class ProviderModel extends ProviderEntity {
  const ProviderModel({required super.id, required super.provider});

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(id: json['id'], provider: json['provider']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'provider': provider};
  }
}
