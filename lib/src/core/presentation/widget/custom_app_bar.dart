import 'package:blog/src/core/presentation/constants/index.dart';
import 'package:blog/src/core/presentation/extension/loc.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/dependency_injection.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomToolBar extends ConsumerStatefulWidget {
  const CustomToolBar(
      {super.key, required this.padding, required this.iconSize});

  final EdgeInsets padding;
  final double iconSize;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomToolBarState();
}

class _CustomToolBarState extends ConsumerState<CustomToolBar> {
  Language get targetLanguage {
    switch (ref.watch(settingStateNotifierProvider.notifier).setting.language) {
      case Language.system:
        if (context.loc!.localeName == Language.english.code) {
          return Language.korean;
        } else {
          return Language.english;
        }
      case Language.english:
        return Language.korean;
      case Language.korean:
        return Language.english;
    }
  }

  SystemTheme get targetTheme {
    if (Theme.of(context).brightness == Brightness.light) {
      return SystemTheme.dark;
    } else {
      return SystemTheme.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(settingStateNotifierProvider.notifier);
    return AnimatedPadding(
      duration: kThemeChangeDuration,
      padding: widget.padding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              final setting = ThemeProvider.of(context)
                  .setting
                  .value
                  .copyWith(mode: targetTheme);

              ThemeSettingChange(
                setting: setting,
              ).dispatch(context);

              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(SettingEvent.changeThememode(targetTheme));
            },
            child: Icon(
              targetTheme == SystemTheme.light
                  ? Icons.wb_sunny_outlined
                  : Icons.nights_stay_outlined,
              size: widget.iconSize,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(SettingEvent.changeLanguage(targetLanguage));
            },
            child: Text(
              targetLanguage.code.toUpperCase(),
              style: TextStyle(fontSize: widget.iconSize / 2),
            ),
          )
        ],
      ),
    );
  }
}
