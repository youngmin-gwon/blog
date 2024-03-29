import 'package:blog/src/core/presentation/constants/l10n.dart';
import 'package:blog/src/core/presentation/extension/loc.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/dependency_injection.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});

  @override
  ConsumerState<SettingScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    ref.watch(settingStateNotifierProvider);
    final settings = ref.watch(settingStateNotifierProvider.notifier).setting;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.appTitle,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6?.color,
          ),
        ),
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        // Glue the SettingsController to the theme selection DropdownButton.
        //
        // When a user selects a theme from the dropdown list, the
        // SettingsController is updated, which rebuilds the MaterialApp.
        child: Column(
          children: [
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: ThemeMode.values.byName(settings.themeMode.name),
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: (ThemeMode? themeMode) {
                if (themeMode != null) {
                  ref
                      .read(settingStateNotifierProvider.notifier)
                      .mapEventToState(
                        SettingEvent.changeThememode(
                            SystemTheme.values.byName(themeMode.name)),
                      );
                }
              },
              items: [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text(context.loc!.system),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text(context.loc!.light),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text(context.loc!.dark),
                )
              ],
            ),
            DropdownButton<Language>(
              // Read the selected themeMode from the controller
              value: Language.values.byName(settings.language.name),
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: (Language? language) {
                if (language != null) {
                  ref
                      .read(settingStateNotifierProvider.notifier)
                      .mapEventToState(
                        SettingEvent.changeLanguage(
                            Language.values.byName(language.name)),
                      );
                }
              },
              items: [
                DropdownMenuItem(
                  value: Language.system,
                  child: Text(context.loc!.system),
                ),
                DropdownMenuItem(
                  value: Language.english,
                  child: Text(context.loc!.english),
                ),
                DropdownMenuItem(
                  value: Language.korean,
                  child: Text(context.loc!.korean),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
