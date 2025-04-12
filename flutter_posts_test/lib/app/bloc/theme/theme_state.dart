import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';

abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeEnum themeEnum;
  ThemeLoaded(this.themeEnum);
}

