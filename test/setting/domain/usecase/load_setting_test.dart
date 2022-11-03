import 'package:blog/src/core/domain/entity/no_params.dart';
import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/usecase/load_setting.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_setting_repository.dart';

void main() {
  late MockSettingRepository mockRepository;
  late LoadSetting usecase;

  setUp(
    () {
      mockRepository = MockSettingRepository();
      usecase = LoadSetting(
        repository: mockRepository,
      );
    },
  );

  final tTheme = Setting.initial().copyWith(themeMode: SettingThemeMode.dark);

  test(
    'should get theme String from the repository',
    () async {
      /// arrange
      when(() => mockRepository.loadSetting()).thenAnswer(
        (invocation) async => Right(tTheme),
      );

      /// act
      final result = await usecase(const NoParams());

      /// assert
      expect(result, Right(tTheme));
      verify(mockRepository.loadSetting);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
