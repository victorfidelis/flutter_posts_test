import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_bloc.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_posts_test/app/bloc/theme/theme_state.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/repository/auth/firebase_auth_repository.dart';
import 'package:flutter_posts_test/app/repository/post/dio_post_repository.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/repository/theme_repository/shared_theme_repository.dart';
import 'package:flutter_posts_test/app/repository/user/firebase_user_repository.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/shared/enum/theme_enum.dart';
import 'package:flutter_posts_test/app/shared/themes/theme.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_loading.dart';
import 'package:flutter_posts_test/app/view/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(create: (_) => FirebaseUserRepository()),
        RepositoryProvider<PostRepository>(create: (_) => DioPostRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => WrapperBloc()),
          BlocProvider(
            create:
                (_) => LoginBloc(
                  authRepository: FirebaseAuthRepository(),
                  userRepository: FirebaseUserRepository(),
                ),
          ),
          BlocProvider(create: (_) => ThemeBloc(themeRepository: SharedThemeRepository())),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            if (state is ThemeInitial) {
              return const Center(child: CustomLoading());
            }

            final currentTheme = (state as ThemeLoaded).themeEnum;
            final theme =
                currentTheme == ThemeEnum.lightMode
                    ? MaterialTheme().light()
                    : MaterialTheme().dark();

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/wrapper',
              onGenerateRoute: getRoute,
              theme: theme,
            );
          },
        ),
      ),
    );
  }
}
