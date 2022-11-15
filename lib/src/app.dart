import 'package:blog/src/core/key_constant.dart';
import 'package:blog/src/core/presentation/constants/l10n.dart';
import 'package:blog/src/core/presentation/constants/index.dart';
import 'package:blog/src/core/presentation/extension/loc.dart';
import 'package:blog/src/core/presentation/route/app_router.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/dependency_injection.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The Widget that configures your application.
class AppWidget extends ConsumerStatefulWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AppWidget> createState() => _AppState();
}

class _AppState extends ConsumerState<AppWidget> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref
          .read(settingStateNotifierProvider.notifier)
          .mapEventToState(const SettingEvent.loadTheme()),
    );
  }

  /// ! warning
  /// AppLocalizations.of(context) returns null on first frame
  /// but it rebuilds immediately afterward.
  Locale _getLocale(Setting setting) {
    if (setting.language == Language.system) {
      return Locale.fromSubtags(
          languageCode: context.loc?.localeName ?? kLanguageCodeEnglish);
    } else {
      return Locale.fromSubtags(languageCode: setting.language.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(settingStateNotifierProvider);
    final setting = ref.watch(settingStateNotifierProvider.notifier).setting;
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      locale: _getLocale(setting),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      onGenerateTitle: (BuildContext context) => context.loc!.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.values.byName(setting.themeMode.name),
    );
  }
}
