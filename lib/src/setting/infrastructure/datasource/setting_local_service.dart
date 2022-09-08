import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/infrastructure/model/setting_dto.dart';

abstract class SettingLocalService {
  Future<SettingDTO> get setting;
  Future<void> saveThememode(SettingThememode themeMode);
  Future<void> saveLanguageSetting(SettingLanguage language);
}
