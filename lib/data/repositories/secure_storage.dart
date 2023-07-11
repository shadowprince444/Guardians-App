import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pet_adoption_app/domain/repository_interfaces/secure_storage.dart';

class SecureStorageService extends ISecureStorageRepository {
  final _storage = const FlutterSecureStorage();

  SecureStorageService._();

  // Singleton instance of SecureStorageUtil
  static final SecureStorageService instance = SecureStorageService._();

  // Key for storing the dark theme preference
  final String _keyIsDarkTheme = 'isDarkTheme';

  // Method to set the dark theme preference
  // It writes the value to the secure storage
  // Note: The method does not have a return type specified, so it defaults to dynamic
  @override
  setIsDarkTheme(bool value) async {
    await _storage.write(key: _keyIsDarkTheme, value: "$value");
  }

  // Method to get the dark theme preference
  // It reads the value from the secure storage and converts it to a boolean
  @override
  Future<bool> get isDarkTheme async {
    // Read the value from the secure storage
    String? storedValue = await _storage.read(key: _keyIsDarkTheme);
    // Convert the stored value to a boolean
    // If the stored value is 'true', return true; otherwise, return false
    return storedValue == "true" ? true : false;
  }
}
