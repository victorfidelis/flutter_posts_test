sealed class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}

class LogoutButtonPressed extends LoginEvent {
  LogoutButtonPressed();
}

