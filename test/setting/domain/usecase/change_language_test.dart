import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/usecase/change_language.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_i_setting_repository.dart';

void main() {
  late MockISettingRepository repository;
  late ChangeLanguage usecase;

  setUp(
    () {
      repository = MockISettingRepository();
      usecase = ChangeLanguage(repository: repository);
    },
  );

  setUpAll(() {
    registerFallbackValue(SettingLanguage.english);
  });

  group(
    "ChangeLanguage",
    () {
      test(
        "should change language setting behind",
        () async {
          // arrange
          const tLanguage = SettingLanguage.english;
          when(() => repository.updateLanguage(any()))
              .thenAnswer((_) async => const Right(unit));

          // act
          final results = await usecase(tLanguage);

          // assert
          expect(results, const Right(unit));
          verify(() => repository.updateLanguage(tLanguage));
          verifyNoMoreInteractions(repository);
        },
      );
    },
  );
}
