import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/repository/auth/auth_repository.dart';
import 'package:flutter_posts_test/app/repository/auth/firebase_auth_repository.dart';
import 'package:flutter_posts_test/app/repository/user/firebase_user_repository.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/view/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => FirebaseAuthRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => FirebaseUserRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => WrapperBloc())],
        child: MaterialApp(initialRoute: '/wrapper', onGenerateRoute: getRoute),
      ),
    );
  }
}
