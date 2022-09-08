import 'package:blog/src/core/domain/entities/exceptions.dart';
import 'package:blog/src/core/domain/entities/failure.dart';
import 'package:blog/src/settings/domain/entity/setting.dart';
import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';
import 'package:blog/src/settings/infrastructure/repository/setting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_setting_service.dart';

void main() {
  late SettingRepository repository;
  late MockSettingService mockService;
  setUp(
    () {
      mockService = MockSettingService();
      repository = SettingRepository(
        localService: mockService,
      );
    },
  );

  const tTheme = 'dark';
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
              .thenThrow(const InternalCacheException(message: ""));

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
          when(() => mockService.saveThemeMode(any())).thenAnswer((_) async {});

          /// act
          final result = await repository.updateThememode(tTheme);

          /// assert
          expect(result, const Right(unit));
          verify(() => mockService.saveThemeMode(tTheme));
          verifyNoMoreInteractions(mockService);
        },
      );

      test(
        "should throw InternalCacheException when the service call is not successful",
        () async {
          /// arrange
          when(() => mockService.saveThemeMode(any()))
              .thenThrow(const InternalCacheException(message: ""));

          /// act
          final result = await repository.updateThememode(tTheme);

          /// assert
          expect(result, isA<Left<Failure, Unit>>());
          verify(() => mockService.saveThemeMode(tTheme));
          verifyNoMoreInteractions(mockService);
        },
      );
    },
  );
}
