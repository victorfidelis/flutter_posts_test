import 'package:flutter_posts_test/app/model/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String? emailMessage;
  final String? passwordMessage;
  final String? genericMessage;
  LoginFailure({
    this.emailMessage,
    this.passwordMessage,
    this.genericMessage,
  });
}
