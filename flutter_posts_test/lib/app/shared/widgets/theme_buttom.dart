import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_event.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_state.dart';
import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';

class ThemeButtom extends StatelessWidget {
  const ThemeButtom({super.key});

  @override
  Widget build(BuildContext context) {
    final themeEnum = (context.read<ThemeBloc>().state as ThemeLoaded).themeEnum;
    final isDark = themeEnum == ThemeEnum.darkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: IconButton(
        onPressed: () {
          final ThemeEnum newTheme;
          if (isDark) {
            newTheme = ThemeEnum.lightMode;
          } else {
            newTheme = ThemeEnum.darkMode;
          }
          context.read<ThemeBloc>().add(ChangeTheme(newTheme));
        },
        icon: Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
      ),
    );
  } 
}
