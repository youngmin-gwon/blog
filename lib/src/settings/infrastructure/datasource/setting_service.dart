import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';

abstract class SettingService {
  Future<SettingDTO> get setting;
  Future<void> updateThemeMode(String themeMode);
}
