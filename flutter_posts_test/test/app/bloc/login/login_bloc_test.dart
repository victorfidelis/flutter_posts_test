import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_posts_test/app/bloc/login/login_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_event.dart';
import 'package:flutter_posts_test/app/bloc/login/login_state.dart';
import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_posts_test/app/repository/auth/auth_repository.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late LoginBloc loginBloc;
  late AuthRepository authRepository;
  late UserRepository userRepository;
  setUp(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();
    loginBloc = LoginBloc(authRepository: authRepository, userRepository: userRepository);
  });

  tearDown(() {
    loginBloc.close();
  });

  group('Testando contrutor', () {
    test('Deve constar no estado LoginInitial', () {
      expect(loginBloc.state, isA<LoginInitial>());
    });
  });

  group('Testando evento LoginButtonPressed', () {
    blocTest(
      'Deve emitir os estados LoginLoading e posteriormente LoginFailure quando o email for vazio',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginButtonPressed(email: '', password: '')),
      expect:
          () => [
            isA<LoginLoading>(),
            isA<LoginFailure>().having(
              (state) => state.emailMessage,
              'emailMessage',
              'Email não pode ser vazio',
            ),
          ],
    );

    blocTest(
      'Deve emitir os estados LoginLoading e posteriormente LoginFailure quando o password for vazio',
      build: () => loginBloc,
      act: (bloc) => bloc.add(LoginButtonPressed(email: 'johndoe@gmail.com', password: '')),
      expect:
          () => [
            isA<LoginLoading>(),
            isA<LoginFailure>().having(
              (state) => state.passwordMessage,
              'passwordMessage',
              'Senha não pode ser vazia',
            ),
          ],
    );

    blocTest(
      'Deve emitir os estados LoginLoading e posteriormente LoginSuccess quando um conta válida for fornecida',
      build: () => loginBloc,
      act: (bloc) {
        final email = 'johndoe@gmail.com';
        final password = '1234';
        User user = User(
          name: 'John',
          surname: 'Doe',
          email: 'johndoe@gmail.com',
          profilePicture: 'http://example.com/profile.jpg',
          backgroundImage: 'http://example.com/background.jpg',
          age: 30,
          numberOfPosts: 30,
          likes: ['Filmes', 'Tecnologia'],
        );

        when(
          () => authRepository.signInEmailPassword(email: email, password: password),
        ).thenAnswer((_) async => Either.right(unit));
        when(
          () => userRepository.getUserByEmail(email),
        ).thenAnswer((_) async => Either.right(user));

        bloc.add(LoginButtonPressed(email: email, password: password));
      },
      expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );
  });

  group('Testando evento LogoutButtonPressed', () {
    blocTest(
      'Deve emitir o estado LoginInitial quando o logout for efetuado',
      build: () => loginBloc,
      act: (bloc) {
        when(() => authRepository.signOut()).thenAnswer((_) async => Either.right(unit));
        bloc.add(LogoutButtonPressed());
      },
      expect: () => [isA<LoginInitial>()],
    );
  });
}
