import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final String? address;

  const UserEntity({
    this.id,
    this.email,
    this.password,
    this.name,
    this.phone,
    this.address,
  });

  @override
  List<Object?> get props => [id, email, password, name, phone, address];
}
