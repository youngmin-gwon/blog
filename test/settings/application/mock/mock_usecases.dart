import 'package:blog/src/settings/domain/usecase/load_setting.dart';
import 'package:blog/src/settings/domain/usecase/change_thememode.dart';
import 'package:mocktail/mocktail.dart';

class MockChangeThememode extends Mock implements ChangeThememode {}

class MockLoadSetting extends Mock implements LoadSetting {}
