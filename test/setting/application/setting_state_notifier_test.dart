import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/core/domain/entity/no_params.dart';
import 'package:blog/src/setting/application/setting_event.dart';
import 'package:blog/src/setting/application/setting_state.dart';
import 'package:blog/src/setting/dependency_injection.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_usecases.dart';

void main() {
  late MockChangeThememode mockChangeThememode;
  late MockLoadSetting mockLoadSetting;

  setUp(
    () {
      mockChangeThememode = MockChangeThememode();
      mockLoadSetting = MockLoadSetting();
    },
  );

  setUpAll(
    () {
      // any()자리에 해당 Parameter를 넣을 수  있게 만들어줌
      registerFallbackValue(const NoParams());
      registerFallbackValue(SettingThememode.dark);
    },
  );

  Future<void> setUpProviderContainer(
      Future<void> Function(ProviderContainer ref) onProcess) async {
    final container = ProviderContainer(
      overrides: [
        loadSettingProvider.overrideWithValue(mockLoadSetting),
        changeThememodeProvider.overrideWithValue(mockChangeThememode),
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
      final tSettingSystem = Setting.initial();
      final tSettingDark =
          tSettingSystem.copyWith(themeMode: SettingThememode.dark);

      test(
        'should pass the call for the use case',
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockLoadSetting(any()))
                  .thenAnswer((_) async => Right(tSettingDark));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.loadTheme());
              await untilCalled(() => mockLoadSetting(any()));

              // assert
              verify(() => mockLoadSetting(const NoParams()));
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
              when(() => mockLoadSetting(any()))
                  .thenAnswer((_) async => Right(tSettingDark));

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
              await untilCalled(() => mockLoadSetting(any()));
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
              when(() => mockLoadSetting(any()))
                  .thenAnswer((_) async => const Left(Failure.cache));

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
              await untilCalled(() => mockLoadSetting(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.error());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // arrange
              when(() => mockLoadSetting(any()))
                  .thenAnswer((_) async => Right(tSettingDark));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.loadTheme());

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.loading());

              // acting
              await untilCalled(() => mockLoadSetting(any()));
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
      const tTheme = SettingThememode.dark;

      final tSettingSystem = Setting.initial();
      final tSettingDark = tSettingSystem.copyWith(themeMode: tTheme);

      test(
        'should pass the call for the use case',
        () async {
          setUpProviderContainer(
            (ref) async {
              // arrange
              when(() => mockChangeThememode(any()))
                  .thenAnswer((_) async => const Right(unit));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.updateThemeMode(tTheme));
              await untilCalled(() => mockChangeThememode(any()));

              // assert
              verify(() => mockChangeThememode(tTheme));
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
              when(() => mockChangeThememode(any()))
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
              await untilCalled(() => mockChangeThememode(any()));
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
              when(() => mockChangeThememode(any()))
                  .thenAnswer((_) async => const Left(Failure.cache));

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
              await untilCalled(() => mockChangeThememode(any()));
              await Future.microtask(() {});

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.error());
              expect(ref.read(settingStateNotifierProvider.notifier).setting,
                  tSettingSystem);

              // arrange
              when(() => mockChangeThememode(any()))
                  .thenAnswer((_) async => const Right(unit));

              // act
              ref
                  .read(settingStateNotifierProvider.notifier)
                  .mapEventToState(const SettingEvent.updateThemeMode(tTheme));

              // assert
              expect(ref.read(settingStateNotifierProvider),
                  const SettingState.saving());

              // acting
              await untilCalled(() => mockChangeThememode(any()));
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
