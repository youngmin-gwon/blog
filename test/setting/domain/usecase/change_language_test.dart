import 'package:blog/src/setting/domain/entity/setting.dart';
import 'package:blog/src/setting/domain/usecase/change_language.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_setting_repository.dart';

void main() {
  late MockSettingRepository repository;
  late ChangeLanguage usecase;

  setUp(
    () {
      repository = MockSettingRepository();
      usecase = ChangeLanguage(repository: repository);
    },
  );

  setUpAll(() {
    registerFallbackValue(Language.english);
  });

  const tLanguage = Language.english;
  group(
    "ChangeLanguage",
    () {
      test(
        "should change language setting behind",
        () async {
          // arrange
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
