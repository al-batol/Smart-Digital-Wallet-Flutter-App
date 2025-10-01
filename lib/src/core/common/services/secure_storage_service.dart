import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;
  SecureStorageService({required FlutterSecureStorage storage})
    : _storage = storage;

  Future<void> writeString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String> readString(String key) async {
    return await _storage.read(key: key) ?? '';
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
