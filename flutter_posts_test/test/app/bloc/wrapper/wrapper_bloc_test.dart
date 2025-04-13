import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_event.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_state.dart';
import 'package:flutter_posts_test/app/model/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late WrapperBloc wrapperBloc;

  setUp(() {
    wrapperBloc = WrapperBloc();
  });

  tearDown(() {
    wrapperBloc.close();
  });

  group('Testando construtor', () {
    test('Deve constar no estado LoggedOut', () {
      expect(wrapperBloc.state, isA<LoggedOut>());
    });
  });

  group('Testando evento LogIn', () {
    User user = User(
      name: 'John',
      surname: 'Doe',
      email: 'johndoe@gmail.com',
      profilePicture: 'https://example.com/profile.jpg',
      backgroundImage: 'https://example.com/background.jpg',
      age: 30,
      numberOfPosts: 30,
      likes: ['Filmes', 'Música'],
    );
    blocTest(
      'Deve emitir o estado LoggedIn',
      build: () => wrapperBloc,
      act: (bloc) => bloc.add(LogIn(user)),
      expect: () => [isA<LoggedIn>().having((status) => status.user, 'Usuário', user)],
    );
  });

  group('Testando evento LogOut', () {
    blocTest(
      'Deve emitir o estado LoggedOut',
      build: () => wrapperBloc,
      act: (bloc) => bloc.add(LogOut()),
      expect: () => [isA<LoggedOut>()],
    );
  });
}
