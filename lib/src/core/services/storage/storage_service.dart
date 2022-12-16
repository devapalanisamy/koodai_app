import 'dart:convert';
import 'package:ConsumerApp/src/core/configs/storage_constants.dart';
import 'package:ConsumerApp/src/core/services/storage/i_storage_service.dart';
import 'package:hive/hive.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService extends IStorageService {
  Future<T> getEncryptedValue<T>(String key) async {
    final secureKey = await _getSecureKey();
    final box = await Hive.openBox(StorageConstants.encrypted,
        encryptionKey: secureKey);
    return box.get(key);
  }

  Future<T> getUnencryptedValue<T>(String key) async {
    final box = await Hive.openBox(StorageConstants.unencrypted);
    return box.get(key);
  }

  Future<void> setEncryptedValue<T>(String key, T value) async {
    final secureKey = await _getSecureKey();
    final box = await Hive.openBox(StorageConstants.encrypted,
        encryptionKey: secureKey);
    box.put(key, value);
  }

  Future<void> setUnencryptedValue<T>(String key, T value) async {
    final box = await Hive.openBox(StorageConstants.unencrypted);
    box.put(key, value);
  }

  Future<List<int>> _createNewSecureKey() async {
    final secureKey = Hive.generateSecureKey();
    final secureStorage = new FlutterSecureStorage();
    await secureStorage.write(
        key: StorageConstants.secureStorageKey, value: json.encode(secureKey));
    return secureKey;
  }

  Future<List<int>> _getSecureKey() async {
    final storage = new FlutterSecureStorage();
    final key = await storage.read(key: StorageConstants.secureStorageKey);
    if (key != null) {
      final secureKeyString = json.decode(key);
      return List<int>.from(secureKeyString);
    }
    return await _createNewSecureKey();
  }

  Future<bool> clear() async {
    await Hive.deleteFromDisk();
    return true;
  }
}
