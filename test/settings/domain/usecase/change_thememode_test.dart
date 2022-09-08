import 'package:blog/src/settings/domain/usecase/change_thememode.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_i_setting_repository.dart';

void main() {
  late MockISettingRepository mockRepository;
  late ChangeThememode usecase;

  setUp(
    () {
      mockRepository = MockISettingRepository();
      usecase = ChangeThememode(
        repository: mockRepository,
      );
    },
  );

  const tTheme = 'dark';
  test(
    "should update theme from the repository",
    () async {
      when(() => mockRepository.updateThememode(tTheme)).thenAnswer(
        (invocation) async => const Right(unit),
      );

      /// act
      final result = await usecase(tTheme);

      /// assert
      expect(result, const Right(unit));
      verify(() => mockRepository.updateThememode(tTheme));
      verifyNoMoreInteractions(mockRepository);
    },
  );
}
