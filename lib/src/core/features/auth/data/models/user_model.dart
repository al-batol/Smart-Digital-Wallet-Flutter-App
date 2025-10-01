import 'package:smart_digital_wallet/src/core/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.email,
    super.password,
    super.name,
    super.phone,
    super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
}
