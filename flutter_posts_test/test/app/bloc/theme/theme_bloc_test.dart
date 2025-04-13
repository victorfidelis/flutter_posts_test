import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_event.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_state.dart';
import 'package:flutter_posts_test/app/repository/theme_repository/theme_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  late ThemeBloc themeBloc;
  late ThemeRepository themeRepository;
  setUp(() {
    themeRepository = MockThemeRepository();

    when(
      () => themeRepository.getTheme(),
    ).thenAnswer((_) async => Either.right(ThemeEnum.darkMode));

    themeBloc = ThemeBloc(themeRepository: themeRepository);
  });
  tearDown(() {
    themeBloc.close();
  });

  group('Testando evento LoadTheme', () {
    blocTest(
      'Deve emitir o estado ThemeLoaded',
      build: () => themeBloc,
      act: (bloc) {
        when(
          () => themeRepository.getTheme(),
        ).thenAnswer((_) async => Either.right(ThemeEnum.lightMode));
        bloc.add(LoadTheme());
      },
      expect:
          () => [
            isA<ThemeLoaded>().having(
              (status) => status.themeEnum,
              'Tema',
              equals(ThemeEnum.lightMode),
            ),
          ],
    );
  });

  group('Testando evento ChangeTheme', () {
    blocTest(
      'Deve emitir o estado ThemeLoaded com o tema passado',
      build: () => themeBloc,
      act: (bloc) {
        when(
          () => themeRepository.setTheme(ThemeEnum.lightMode),
        ).thenAnswer((_) async => Either.right(unit));
        bloc.add(ChangeTheme(ThemeEnum.lightMode));
      },
      expect:
          () => [
            isA<ThemeLoaded>().having(
              (status) => status.themeEnum,
              'Tema',
              equals(ThemeEnum.lightMode),
            ),
          ],
    );
  });
}
