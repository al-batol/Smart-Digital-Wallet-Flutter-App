import 'package:smart_digital_wallet/src/core/features/pay_bill/domain/entities/bill_type_entity.dart';

class BillTypeModel extends BillTypeEntity {
  const BillTypeModel({required super.id, required super.billType});

  factory BillTypeModel.fromJson(Map<String, dynamic> json) {
    return BillTypeModel(
      id: json['id'] as int,
      billType: json['billType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'billType': billType};
  }
}
