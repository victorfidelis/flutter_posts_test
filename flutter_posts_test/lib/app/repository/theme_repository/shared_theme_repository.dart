import 'package:flutter_posts_test/app/repository/theme_repository/theme_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedThemeRepository implements ThemeRepository {
  final _key = 'theme';
  
  @override
  Future<Either<Failure, ThemeEnum>> getTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final int? theme = prefs.getInt(_key);
      if (theme != null) {
        return Either.right(ThemeEnum.values[theme]);
      } else {
        return Either.left(Failure('Theme não encontrado.'));
      }
    } catch (e) {
      return Either.left(Failure('Falha ao consultar o tema: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> setTheme(ThemeEnum theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt(_key, theme.index);
      return Either.right(unit);
    } catch (e) {
      return Either.left(Failure('Falha ao alterar o tema: $e'));
    }
  }
}
