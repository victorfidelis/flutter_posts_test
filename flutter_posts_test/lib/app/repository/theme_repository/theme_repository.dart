import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/failure.dart';

abstract class ThemeRepository {
  Future<Either<Failure, Unit>> setTheme(ThemeEnum theme);
  Future<Either<Failure, ThemeEnum>> getTheme();
}