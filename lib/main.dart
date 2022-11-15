import 'package:blog/src/core/key_constant.dart';
import 'package:blog/src/setting/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:blog/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final stringBoxStorage = await Hive.openBox<String>(kSettingBoxKey);

  runApp(
    ProviderScope(
      overrides: [hiveStringBoxProvider.overrideWithValue(stringBoxStorage)],
      child: const AppWidget(),
    ),
  );
}
