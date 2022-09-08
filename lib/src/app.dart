import 'package:blog/src/core/presentation/constants/index.dart';
import 'package:blog/src/core/presentation/route/app_router.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The Widget that configures your application.
class App extends ConsumerStatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () {
        ref
            .read(settingStateNotifierProvider.notifier)
            .mapEventToState(const SettingEvent.loadTheme());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(settingStateNotifierProvider);
    final setting = ref.watch(settingStateNotifierProvider.notifier).setting;
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      restorationScopeId: 'app',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('ko', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.values.byName(setting.themeMode.name),
    );
  }
}
