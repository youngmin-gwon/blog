// import 'package:blog/src/core/domain/entities/failure.dart';
// import 'package:blog/src/core/domain/entities/no_params.dart';
// import 'package:blog/src/settings/application/setting_event.dart';
// import 'package:blog/src/settings/application/setting_state.dart';
// import 'package:blog/src/settings/dependency_injection.dart';
// import 'package:blog/src/settings/domain/entities/setting.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// import 'mocks/mock_usecases.dart';

void main() {
  // late MockUpdateTheme mockUpdateTheme;
  // late MockLoadTheme mockLoadTheme;

  // const internalErrorMessage = 'Internal Error';

  // setUp(
  //   () {
  //     mockUpdateTheme = MockUpdateTheme();
  //     mockLoadTheme = MockLoadTheme();
  //   },
  // );

  // setUpAll(
  //   () {
  //     // any()자리에 해당 Parameter를 넣을 수  있게 만들어줌
  //     registerFallbackValue(const NoParams());
  //   },
  // );

  // ProviderContainer _setProviderContainerForTest() {
  //   final container = ProviderContainer(
  //     overrides: [
  //       loadThemeProvider.overrideWithValue(mockLoadTheme),
  //       updateThemeProvider.overrideWithValue(mockUpdateTheme),
  //     ],
  //   );
  //   addTearDown(container.dispose);
  //   return container;
  // }

  // test(
  //   'initial state should be empty',
  //   () async {
  //     // should write line underneath for test
  //     final container = _setProviderContainerForTest();
  //     expect(container.read(settingStateNotifierProvider),
  //         const SettingState.empty());
  //   },
  // );

  // group(
  //   'UpdateTheme',
  //   () {
  //     // The event takes in a String
  //     const tTheme = 'dark';
  //     // Settings Instance

  //     test(
  //       'should pass the call for the concrete use case',
  //       () async {
  //         final container = _setProviderContainerForTest();
  //         when(() => mockUpdateTheme(any()))
  //             .thenAnswer((_) async => const Right(unit));
  //         container
  //             .read(settingStateNotifierProvider.notifier)
  //             .mapEventToState(const SettingEvent.updateThemeMode(tTheme));
  //         await untilCalled(() => mockUpdateTheme(any()));

  //         verify(() => mockUpdateTheme(tTheme));
  //       },
  //     );

  //     test(
  //       "should emit [saving, saved] when setting data succeeds",
  //       () async {
  //         final container = _setProviderContainerForTest();
  //         when(() => mockUpdateTheme(any()))
  //             .thenAnswer((_) async => const Right(unit));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.empty());

  //         container
  //             .read(settingStateNotifierProvider.notifier)
  //             .mapEventToState(const SettingEvent.updateThemeMode(tTheme));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.saving());

  //         await untilCalled(() => mockUpdateTheme(any()));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.saved());
  //       },
  //     );

  //     test(
  //       "should emit [saving, error] when setting data fails",
  //       () async {
  //         final container = _setProviderContainerForTest();
  //         addTearDown(container.dispose);
  //         when(() => mockUpdateTheme(any())).thenAnswer(
  //             (_) async => Left(Failure.internal(internalErrorMessage)));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.empty());

  //         container
  //             .read(settingStateNotifierProvider.notifier)
  //             .mapEventToState(const SettingEvent.updateThemeMode(tTheme));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.saving());

  //         await untilCalled(() => mockUpdateTheme(any()));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.error());
  //       },
  //     );
  //   },
  // );

  // group(
  //   'LoadTheme',
  //   () {
  //     const tSettings = Setting(themeMode: 'system');

  //     test(
  //       "should get data from the usecase",
  //       () async {
  //         final container = _setProviderContainerForTest();

  //         when(() => mockLoadTheme(any()))
  //             .thenAnswer((_) async => const Right(tSettings));

  //         container
  //             .read(settingStateNotifierProvider.notifier)
  //             .mapEventToState(const SettingEvent.loadTheme());

  //         await untilCalled(() => mockLoadTheme(any()));

  //         verify(() => mockLoadTheme(any()));
  //       },
  //     );

  //     test(
  //       "should emit [loading, loaded] when getting data succeeds",
  //       () async {
  //         final container = _setProviderContainerForTest();
  //         when(() => mockLoadTheme(any())).thenAnswer(
  //           (_) async => const Right(tSettings),
  //         );

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.empty());

  //         container
  //             .read(settingStateNotifierProvider.notifier)
  //             .mapEventToState(const SettingEvent.loadTheme());

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.loading());

  //         await untilCalled(() => mockLoadTheme(any()));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.loaded());
  //       },
  //     );
  //     test(
  //       "should emit [loading, error] when getting data fails",
  //       () async {
  //         final container = _setProviderContainerForTest();
  //         when(() => mockLoadTheme(any())).thenAnswer(
  //           (_) async => const Left(Failure.internal(internalErrorMessage)),
  //         );

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.empty());

  //         container
  //             .read(settingStateNotifierProvider.notifier)
  //             .mapEventToState(const SettingEvent.loadTheme());

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.loading());

  //         await untilCalled(() => mockLoadTheme(any()));

  //         expect(container.read(settingStateNotifierProvider),
  //             const SettingState.error());
  //       },
  //     );
  //   },
  // );
}
