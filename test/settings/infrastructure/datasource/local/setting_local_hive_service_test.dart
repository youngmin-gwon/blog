import 'package:blog/src/core/constant.dart';
import 'package:blog/src/settings/infrastructure/datasource/local/settings_local_hive_service.dart';
import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_hive_string_box.dart';

void main() {
  late MockHiveStringBox storage;
  late SettingLocalHiveService localService;

  final tSettingDto = SettingDTO.initial();

  setUp(
    () {
      storage = MockHiveStringBox();
      localService = SettingLocalHiveService(storage: storage);
    },
  );

  group(
    "setting",
    () {
      test(
        "should return SettingDTO from Box<String> when there is one cached",
        () async {
          // arrange
          when(() => storage.get(any()))
              .thenAnswer((_) => tSettingDto.toJson());

          // act
          final results = await localService.setting;

          // assert
          verify(() => storage.get(kSettingValueKey));
          expect(results, tSettingDto);
        },
      );

      test(
        "should return default SettingDTO from Box<String> when there is none",
        () async {
          // arrange
          when(() => storage.get(any())).thenAnswer((_) => null);

          // act
          final results = await localService.setting;

          // assert
          verify(() => storage.get(kSettingValueKey));
          expect(results, tSettingDto);
        },
      );
    },
  );

  group(
    "updateThemeMode",
    () {
      test(
        "should call Box.put() to cache the data",
        () async {
          // arrange
          when(() => storage.put(any(), any()))
              .thenAnswer((invocation) => Future.value());

          // act
          await localService.saveThemeMode(tSettingDto.themeMode);
          // assert
          verify(() => storage.put(kSettingValueKey, tSettingDto.toJson()));
        },
      );
    },
  );
}
