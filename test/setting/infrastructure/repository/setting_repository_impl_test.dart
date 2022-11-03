import 'package:blog/src/core/domain/entity/exception.dart';
import 'package:blog/src/core/domain/entity/failure.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/infrastructure/model/setting_dto.dart';
import 'package:blog/src/setting/infrastructure/repository/setting_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_setting_service.dart';

void main() {
  late SettingRepositoryImpl repository;
  late MockSettingService mockService;

  setUp(
    () {
      mockService = MockSettingService();
      repository = SettingRepositoryImpl(
        localService: mockService,
      );
    },
  );

  setUpAll(() {
    registerFallbackValue(SettingThemeMode.dark);
    registerFallbackValue(Language.english);
  });

  const tTheme = SettingThemeMode.dark;
  const tLanguage = Language.english;
  final tSettings = Setting.initial();

  group(
    'loadTheme',
    () {
      test(
        "should return the data when the service call is successful",
        () async {
          /// arrange
          when(() => mockService.setting)
              .thenAnswer((_) async => SettingDTO.fromDomain(tSettings));

          /// act
          final result = await repository.loadSetting();

          /// assert
          expect(result, Right(tSettings));
          verify(() => mockService.setting);
        },
      );

      test(
        "should throw InternalCacheException when the service call is not successful",
        () async {
          /// arrange
          when(() => mockService.setting)
              .thenThrow(const InternalCacheException(Failure.cache));

          /// act
          final results = await repository.loadSetting();

          /// assert
          expect(results, isA<Left<Failure, Setting>>());
          verify(() => mockService.setting);
          verifyNoMoreInteractions(mockService);
        },
      );
    },
  );

  group(
    'updateThemeMode',
    () {
      test(
        "should pass the call when the service call is successful",
        () async {
          /// arrange
          when(() => mockService.saveThememode(any())).thenAnswer((_) async {});

          /// act
          final result = await repository.updateThememode(tTheme);

          /// assert
          expect(result, const Right(unit));
          verify(() => mockService.saveThememode(tTheme));
          verifyNoMoreInteractions(mockService);
        },
      );

      test(
        "should throw InternalCacheException when the service call is not successful",
        () async {
          /// arrange
          when(() => mockService.saveThememode(any()))
              .thenThrow(const InternalCacheException(Failure.cache));

          /// act
          final result = await repository.updateThememode(tTheme);

          /// assert
          expect(result, isA<Left<Failure, Unit>>());
          verify(() => mockService.saveThememode(tTheme));
          verifyNoMoreInteractions(mockService);
        },
      );
    },
  );
  group(
    'updateLanguage',
    () {
      test(
        "should pass the call when the service call is successful",
        () async {
          /// arrange
          when(() => mockService.saveLanguageSetting(any()))
              .thenAnswer((_) => Future.value());

          /// act
          final result = await repository.updateLanguage(tLanguage);

          /// assert
          expect(result, const Right(unit));
          verify(() => mockService.saveLanguageSetting(tLanguage));
          verifyNoMoreInteractions(mockService);
        },
      );

      test(
        "should throw InternalCacheException when the service call is not successful",
        () async {
          /// arrange
          when(() => mockService.saveLanguageSetting(any()))
              .thenThrow(const InternalCacheException(Failure.cache));

          /// act
          final result = await repository.updateLanguage(tLanguage);

          /// assert
          expect(result, isA<Left<Failure, Unit>>());
          verify(() => mockService.saveLanguageSetting(tLanguage));
          verifyNoMoreInteractions(mockService);
        },
      );
    },
  );
}
