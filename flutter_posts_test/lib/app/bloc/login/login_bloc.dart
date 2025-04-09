import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_event.dart';
import 'package:flutter_posts_test/app/bloc/login/login_state.dart';
import 'package:flutter_posts_test/app/repository/auth/auth_repository.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepository authRepository;
  UserRepository userRepository;

  LoginBloc({
    required this.authRepository,
    required this.userRepository,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  } 

  Future<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    
    final authEither = await authRepository.signInEmailPassword(email: event.email, password:  event.password);
    if (authEither.isLeft) {
      emit(LoginFailure(genericMessage: authEither.left!.message));
      return;
    }

    final userEither = await userRepository.getUserByEmail(event.email);
    if (userEither.isLeft) {
      emit(LoginFailure(genericMessage: userEither.left!.message));
    } else {
      emit(LoginSuccess(user: userEither.right!));
    }
  } 


}