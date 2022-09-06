import 'package:blog/src/settings/dependency_injection.dart';
import 'package:blog/src/settings/infrastructure/datasources/local/settings_local_hive_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blog/src/app.dart';

Future<void> main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final settingService = SettingLocalHiveService();

  await settingService.initializeDatabase();

  final setting = settingService.savedSettings.toDomain();

  runApp(
    ProviderScope(
      overrides: [
        settingHiveServiceProvider.overrideWithValue(settingService),
        settingProvider.overrideWithValue(StateController(setting))
      ],
      child: const App(),
    ),
  );
}
