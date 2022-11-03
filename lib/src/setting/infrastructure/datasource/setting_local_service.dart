import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/infrastructure/model/setting_dto.dart';

abstract class SettingLocalService {
  Future<SettingDTO> get setting;
  Future<void> saveThememode(SettingThemeMode themeMode);
  Future<void> saveLanguageSetting(Language language);
}
