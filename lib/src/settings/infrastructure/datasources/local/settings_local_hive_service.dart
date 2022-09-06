import 'package:blog/src/settings/infrastructure/datasources/setting_service.dart';
import 'package:blog/src/settings/infrastructure/models/setting_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingLocalHiveService implements SettingService {
  late final Box<String> settingBox;

  SettingDTO get savedSettings => SettingDTO.fromJson(settingBox.values.first);

  Future<void> initializeDatabase() async {
    await Hive.openBox<String>('setting').then((value) => settingBox = value);

    // first time loading
    if (settingBox.values.isEmpty) {
      settingBox.add(const SettingDTO(themeMode: "system").toJson());
    }
  }

  @override
  Future<SettingDTO> get themeMode async => savedSettings;

  @override
  Future<void> updateThemeMode(String themeMode) async {
    await settingBox.put(
        0, savedSettings.copyWith(themeMode: themeMode).toJson());
  }
}
