import 'package:flutter_posts_test/app/model/user.dart';

sealed class WrapperEvent {}

class LogIn extends WrapperEvent {
  final User user;
  LogIn(this.user);
}

class LogOut extends WrapperEvent {}

