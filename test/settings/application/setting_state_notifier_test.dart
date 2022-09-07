import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/core/domain/entities/no_params.dart';
import 'package:blog/src/settings/application/setting_event.dart';
import 'package:blog/src/settings/application/setting_state.dart';
import 'package:blog/src/settings/dependency_injection.dart';
import 'package:blog/src/settings/domain/entity/setting.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_usecases.dart';

void main() {
  late MockUpdateTheme mockUpdateTheme;
  late MockLoadTheme mockLoadTheme;

  setUp(
    () {
      mockUpdateTheme = MockUpdateTheme();
      mockLoadTheme = MockLoadTheme();
    },
  );

  setUpAll(
    () {
      // any()자리에 해당 Parameter를 넣을 수  있게 만들어줌
      registerFallbackValue(const NoParams());
    },
  );

  Future<void> setUpProviderContainer(
      Future<void> Function(ProviderContainer ref) onProcess) async {
    final container = ProviderContainer(
      overrides: [
        loadThemeProvider.overrideWithValue(mockLoadTheme),
        updateThemeProvider.overrideWithValue(mockUpdateTheme),
      ],
    );
    await onProcess(container);
    addTearDown(container.dispose);
  }

  test(
    'initial state should be stable',
    () async {
      setUpProviderContainer(
        (ref) async {
          expect(ref.read(settingStateNotifierProvider),
              const SettingState.stable());
        },
      );
    },
  );
  group(
    'loadTheme',
    () {
      const tSettingSystem = Setting(themeMode: 'system');
      const tSettingDark = Setting(themeMode: 'dark');

      test(
        'should pass the call for the use case',
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockLoadTheme(any()))
                  .thenAnswer((_) async => const Right(tSettingDark));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.loadTheme());
              await untilCalled(() => mockLoadTheme(any()));

              // assert
              verify(() => mockLoadTheme(const NoParams()));
            },
          );
        },
      );

      test(
        "should emit [loading, stable] when loading data succeeds",
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockLoadTheme(any()))
                  .thenAnswer((_) async => const Right(tSettingDark));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.loadTheme());

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.loading());

              // acting
              await untilCalled(() => mockLoadTheme(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingDark);
            },
          );
        },
      );

      test(
        "should emit [loading, error, loading, stable] when setting data fails at first trial and succeeds finally",
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockLoadTheme(any()))
                  .thenAnswer((_) async => const Left(Failure.internal("")));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.loadTheme());

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.loading());

              // acting
              await untilCalled(() => mockLoadTheme(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.error());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // arrange
              when(() => mockLoadTheme(any()))
                  .thenAnswer((_) async => const Right(tSettingDark));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.loadTheme());

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.loading());

              // acting
              await untilCalled(() => mockLoadTheme(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingDark);
            },
          );
        },
      );
    },
  );

  group(
    'UpdateTheme',
    () {
      const tTheme = 'dark';

      const tSettingSystem = Setting(themeMode: "system");
      const tSettingDark = Setting(themeMode: tTheme);

      test(
        'should pass the call for the use case',
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockUpdateTheme(any()))
                  .thenAnswer((_) async => const Right(unit));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.updateThemeMode(tTheme));
              await untilCalled(() => mockUpdateTheme(any()));

              // assert
              verify(() => mockUpdateTheme(tTheme));
            },
          );
        },
      );

      test(
        "should emit [saving, stable] when setting data succeeds",
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockUpdateTheme(any()))
                  .thenAnswer((_) async => const Right(unit));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.updateThemeMode(tTheme));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.saving());

              // acting
              await untilCalled(() => mockUpdateTheme(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingDark);
            },
          );
        },
      );

      test(
        "should emit [saving, error, saving, stable] when setting data fails at first trial and succeeds finally",
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockUpdateTheme(any()))
                  .thenAnswer((_) async => const Left(Failure.internal("")));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.updateThemeMode(tTheme));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.saving());

              // acting
              await untilCalled(() => mockUpdateTheme(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.error());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // arrange
              when(() => mockUpdateTheme(any()))
                  .thenAnswer((_) async => const Right(unit));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.updateThemeMode(tTheme));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.saving());

              // acting
              await untilCalled(() => mockUpdateTheme(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.stable());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingDark);
            },
          );
        },
      );
    },
  );
}
