import 'package:blog/src/core/domain/entities/exceptions.dart';
import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/settings/domain/entities/setting.dart';
import 'package:blog/src/settings/infrastructure/models/setting_dto.dart';
import 'package:blog/src/settings/infrastructure/repositories/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_setting_service.dart';

void main() {
  late SettingRepository repository;
  late MockSettingService mockService;
  setUp(
    () {
      mockService = MockSettingService();
      repository = SettingRepository(
        service: mockService,
      );
    },
  );

  const tTheme = 'dark';
  const tSettings = Setting(
    themeMode: tTheme,
  );

  group(
    'loadTheme',
    () {
      test(
        "should return the data when the service call is successful",
        () async {
          /// arrange
          when(() => mockService.themeMode)
              .thenAnswer((_) async => SettingDTO.fromDomain(tSettings));

          /// act
          final result = await repository.loadTheme();

          /// assert
          expect(result, const Right(tSettings));
          verify(() => mockService.themeMode);
        },
      );

      test(
        "should throw InternalCacheException when the service call is not successful",
        () async {
          /// arrange
          when(() => mockService.themeMode)
              .thenThrow(const InternalCacheException(message: ""));

          /// act
          final results = await repository.loadTheme();

          /// assert
          expect(results, isA<Left<Failure, Setting>>());
          verify(() => mockService.themeMode);
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
          when(() => mockService.updateThemeMode(any()))
              .thenAnswer((_) async {});

          /// act
          final result = await repository.updateTheme(tTheme);

          /// assert
          expect(result, const Right(unit));
          verify(() => mockService.updateThemeMode(tTheme));
          verifyNoMoreInteractions(mockService);
        },
      );

      test(
        "should throw InternalCacheException when the service call is not successful",
        () async {
          /// arrange
          when(() => mockService.updateThemeMode(any()))
              .thenThrow(const InternalCacheException(message: ""));

          /// act
          final result = await repository.updateTheme(tTheme);

          /// assert
          expect(result, isA<Left<Failure, Unit>>());
          verify(() => mockService.updateThemeMode(tTheme));
          verifyNoMoreInteractions(mockService);
        },
      );
    },
  );
}