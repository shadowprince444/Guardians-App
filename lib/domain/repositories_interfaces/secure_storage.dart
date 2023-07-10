abstract class ISecureStorageRepository {
  Future<void> setIsDarkTheme(bool value);
  Future<bool> get isDarkTheme;
}
