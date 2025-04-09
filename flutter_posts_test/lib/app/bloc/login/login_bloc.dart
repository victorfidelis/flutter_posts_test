import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/login/login_event.dart';
import 'package:flutter_posts_test/app/bloc/login/login_state.dart';
import 'package:flutter_posts_test/app/repository/auth/auth_repository.dart';
import 'package:flutter_posts_test/app/repository/user/user_repository.dart';
import 'package:flutter_posts_test/app/shared/either/either_extensions.dart';
import 'package:flutter_posts_test/app/shared/failure.dart/auth_failures.dart';

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

    if (event.email.isEmpty) {
      emit(LoginFailure(emailMessage: 'Email não pode ser vazio'));
      return;
    }
    
    if (event.password.isEmpty) {
      emit(LoginFailure(passwordMessage: 'Senha não pode ser vazia'));
      return;
    }
    
    final authEither = await authRepository.signInEmailPassword(email: event.email, password:  event.password);
    if (authEither.isLeft) {
      if (authEither.left is EmailNotVerifiedFailure) {
        await authRepository.sendEmailVerificationForCurrentUser();
      }

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