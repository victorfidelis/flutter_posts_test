import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_state.dart';
import 'package:flutter_posts_test/app/view/login/login_view.dart';
import 'package:flutter_posts_test/app/view/posts/posts_view.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.amber,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    
    return BlocBuilder<WrapperBloc, WrapperState>(
      builder: (context, state) {
        if (state is LoggedIn) {
          return const PostsView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}
