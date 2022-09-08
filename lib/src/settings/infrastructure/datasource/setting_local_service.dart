import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';

abstract class SettingLocalService {
  Future<SettingDTO> get setting;
  Future<void> saveThemeMode(String themeMode);
  Future<void> saveLanguageSetting(String langCode);
}
