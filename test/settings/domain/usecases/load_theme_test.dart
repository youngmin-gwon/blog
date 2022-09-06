import 'package:blog/src/core/domain/entities/no_params.dart';
import 'package:blog/src/settings/domain/entities/setting.dart';
import 'package:blog/src/settings/domain/usecases/load_theme.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mocks/mock_i_setting_repository.dart';

void main() {
  late MockISettingRepository mockRepository;
  late LoadTheme usecase;

  setUp(
    () {
      mockRepository = MockISettingRepository();
      usecase = LoadTheme(
        repository: mockRepository,
      );
    },
  );

  const tTheme = Setting(themeMode: 'dark');

  test(
    'should get theme String from the repository',
    () async {
      /// arrange
      when(() => mockRepository.loadTheme()).thenAnswer(
        (invocation) async => const Right(tTheme),
      );

      /// act
      final result = await usecase(const NoParams());

      /// assert
      expect(result, const Right(tTheme));
      verify(mockRepository.loadTheme);
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
