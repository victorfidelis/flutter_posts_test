import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_event.dart';
import 'package:flutter_posts_test/app/shared/widget/default_buttom.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 150),
          Text('Posts View'),
          SizedBox(height: 150),
          DefaultButtom(
            label: 'Logout',
            onTap: () {
              context.read<WrapperBloc>().add(LogOut());
            },
          ),
        ],
      ),
    );
  }
}