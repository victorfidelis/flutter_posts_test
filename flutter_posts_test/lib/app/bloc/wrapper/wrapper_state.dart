
import 'package:flutter_posts_test/app/model/user.dart';

abstract class WrapperState {}

class LoggedIn extends WrapperState {
  User user;
  LoggedIn({required this.user});
}
class LoggedOut extends WrapperState {}
