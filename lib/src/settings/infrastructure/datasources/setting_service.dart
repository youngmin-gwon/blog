import 'package:blog/src/settings/infrastructure/models/setting_dto.dart';

abstract class SettingService {
  Future<SettingDTO> get themeMode;
  Future<void> updateThemeMode(String themeMode);
}
