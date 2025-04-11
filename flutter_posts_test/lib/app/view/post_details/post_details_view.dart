import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_bloc.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_event.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_state.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/repository/user_of_post/user_of_post_repository.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_loading.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_text_error.dart';
import 'package:flutter_posts_test/app/view/post_details/widgets/user_of_post_card.dart';

class PostDetailsView extends StatefulWidget {
  final Post post;
  const PostDetailsView({super.key, required this.post});

  @override
  State<PostDetailsView> createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends State<PostDetailsView> {
  late final UserOfPostBloc userOfPostBloc;

  @override
  void initState() {
    userOfPostBloc = UserOfPostBloc(userOfPostRepository: context.read<UserOfPostRepository>());
    userOfPostBloc.add(LoadUserOfPost(widget.post.userId));
    super.initState();
  }

  @override
  void dispose() {
    userOfPostBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes do Post',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.post.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(widget.post.body, style: const TextStyle(fontSize: 16)),
          ),
          BlocBuilder<UserOfPostBloc, UserOfPostState>(
            bloc: userOfPostBloc,
            builder: (context, state) {
              if (state is UserOfPostLoading || state is UserOfPostInitial) {
                return const Center(child: CustomLoading());
              }
              if (state is UserOfPostFailure) {
                return Center(child: CustomTextError(message: state.message));
              }
              final currentState = (state as UserOfPostLoaded);
              return UserOfPostCard(
                user: currentState.userOfPost,
              );
            },
          ),
        ],
      ),
    );
  }
}
