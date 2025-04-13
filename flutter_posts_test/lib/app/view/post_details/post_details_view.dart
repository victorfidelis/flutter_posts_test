import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_bloc.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_event.dart';
import 'package:flutter_posts_test/app/bloc/comment/comment_state.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_bloc.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_event.dart';
import 'package:flutter_posts_test/app/bloc/user_of_post/user_of_post_state.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
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
  late final CommentBloc commentBloc;

  @override
  void initState() {
    userOfPostBloc = UserOfPostBloc(postRepository: context.read<PostRepository>());
    userOfPostBloc.add(LoadUserOfPost(widget.post.userId));

    commentBloc = CommentBloc(postRepository: context.read<PostRepository>());
    commentBloc.add(LoadComments(widget.post.id));

    super.initState();
  }

  @override
  void dispose() {
    userOfPostBloc.close();
    commentBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 45),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: CustomScrollView(
          slivers: [
            buildUserInfo(),
            buildDivider(),
            buildPost(),
            buildDivider(),
            buildCommentsTitle(),
            buildComments(),
            SliverToBoxAdapter(child: const SizedBox(height: 50)),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfo() {
    return SliverToBoxAdapter(
      child: BlocBuilder<UserOfPostBloc, UserOfPostState>(
        bloc: userOfPostBloc,
        builder: (context, state) {
          if (state is UserOfPostLoading || state is UserOfPostInitial) {
            return const Center(child: CustomLoading());
          }
          if (state is UserOfPostFailure) {
            return Center(child: CustomTextError(message: state.message));
          }
          final currentState = (state as UserOfPostLoaded);
          return UserOfPostCard(user: currentState.userOfPost);
        },
      ),
    );
  }

  Widget buildPost() {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.post.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(widget.post.body, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildCommentsTitle() {
    return BlocBuilder<CommentBloc, CommentState>(
      bloc: commentBloc,
      builder: (context, state) {
        if (state is CommentLoading || state is CommentInitial || state is CommentFailure) {
          return SliverToBoxAdapter(child: const SizedBox());
        }

        final quantityComments = (commentBloc.state as CommentLoaded).comments.length;
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Comentários ($quantityComments)',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget buildComments() {
    return BlocBuilder<CommentBloc, CommentState>(
      bloc: commentBloc,
      builder: (context, state) {
        if (state is CommentLoading || state is CommentInitial) {
          return SliverToBoxAdapter(child: const Center(child: CustomLoading()));
        }
        if (state is CommentFailure) {
          return SliverToBoxAdapter(child: Center(child: CustomTextError(message: state.message)));
        }
        final currentState = (state as CommentLoaded);
        return SliverList.builder(
          itemCount: currentState.comments.length,
          itemBuilder: (context, index) {
            final comment = currentState.comments[index];
            return ListTile(title: Text(comment.name), subtitle: Text(comment.body));
          },
        );
      },
    );
  }

  Widget buildDivider() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 4),
          const Divider(thickness: 1),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
