import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';

sealed class ThemeEvent {}
class ChangeTheme extends ThemeEvent {
  final ThemeEnum themeEnum;

  ChangeTheme(this.themeEnum);
}

class LoadTheme extends ThemeEvent {
  LoadTheme();
}
