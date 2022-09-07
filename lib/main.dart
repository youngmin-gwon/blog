import 'package:blog/src/settings/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blog/src/app.dart';

Future<void> main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final stringBoxStorage = await Hive.openBox<String>('setting');

  runApp(
    ProviderScope(
      overrides: [hiveStringBoxProvider.overrideWithValue(stringBoxStorage)],
      child: const App(),
    ),
  );
}
