import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData(String key) async {
    final value = await _storage.read(key: key);
    if (value == null) {
      print('Data not found in secure storage');
    }
    return value;
  }

  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }
}