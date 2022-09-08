import 'dart:convert';

import 'package:blog/src/settings/domain/entity/setting.dart';
import 'package:blog/src/settings/infrastructure/model/setting_dto.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final tSettingDto = SettingDTO.initial();
  final tSettingDtoDark = tSettingDto.copyWith(
    themeMode: 'dark',
  );

  test(
    "should be a subclasss of Settings entity",
    () async {
      // assert
      expect(tSettingDto.toDomain(), isA<Setting>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        "should return a valid model when the JSON themeMode is null",
        () async {
          /// arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('setting_null.json'));

          /// act
          final result = SettingDTO.fromMap(jsonMap);

          /// assert
          expect(result, tSettingDto);
        },
      );

      test(
        "should return a valid model when the JSON themeMode is not null",
        () async {
          /// arrange
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('setting.json'));

          /// act
          final result = SettingDTO.fromMap(jsonMap);

          /// assert
          expect(result, tSettingDtoDark);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          /// act
          final result = tSettingDto.toMap();

          /// assert
          final expectedJsonMap = {
            'themeMode': 'system',
            'langCode': 'en',
          };
          expect(result, expectedJsonMap);
        },
      );
    },
  );
}
