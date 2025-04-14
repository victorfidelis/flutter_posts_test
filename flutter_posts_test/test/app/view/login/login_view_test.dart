import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_bloc.dart';
import 'package:flutter_posts_test/app/repository/auth/auth_repository.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/shared/themes/theme.dart';
import 'package:flutter_posts_test/app/view/login/login_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final AuthRepository authRepository = MockAuthRepository();
  final UserRepository userRepository = MockUserRepository();

  testWidgets('Deve renderizar a tela de login com o header, o campo de email e o campo de senha', (
    tester,
  ) async {
    await tester.pumpWidget(
      BlocProvider(
        create: (_) => LoginBloc(authRepository: authRepository, userRepository: userRepository),
        child: MaterialApp(theme: MaterialTheme().dark(), home: LoginView()),
      ),
    );

    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
  });
}
