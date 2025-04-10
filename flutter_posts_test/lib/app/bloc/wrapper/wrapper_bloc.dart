import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_event.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_state.dart';

class WrapperBloc extends Bloc<WrapperEvent, WrapperState> {
  WrapperBloc() : super(LoggedOut()) {
    on<LogIn>(_onLogIn);
    on<LogOut>(_onLogOut);
  }

  void _onLogIn(LogIn event, Emitter<WrapperState> emit) async {
    emit(LoggedIn(user: event.user));
  }

  void _onLogOut(LogOut event, Emitter<WrapperState> emit) async {
    emit(LoggedOut());
  }
}
