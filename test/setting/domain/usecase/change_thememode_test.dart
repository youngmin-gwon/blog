import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/usecase/change_thememode.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_setting_repository.dart';

void main() {
  late MockSettingRepository mockRepository;
  late ChangeThememode usecase;

  const tTheme = SystemTheme.dark;

  setUp(
    () {
      mockRepository = MockSettingRepository();
      usecase = ChangeThememode(
        repository: mockRepository,
      );
    },
  );

  setUpAll(() {
    registerFallbackValue(SystemTheme.dark);
  });

  test(
    "should update theme from the repository",
    () async {
      when(() => mockRepository.updateThememode(any())).thenAnswer(
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
