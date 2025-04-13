import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_posts_test/app/bloc/post/post_bloc.dart';
import 'package:flutter_posts_test/app/bloc/post/post_event.dart';
import 'package:flutter_posts_test/app/bloc/post/post_state.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_bloc.dart';
import 'package:flutter_posts_test/app/bloc/wrapper/wrapper_event.dart';
import 'package:flutter_posts_test/app/model/post.dart';
import 'package:flutter_posts_test/app/repository/post/post_repository.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_loading.dart';
import 'package:flutter_posts_test/app/shared/widgets/custom_text_error.dart';
import 'package:flutter_posts_test/app/view/posts/widgets/custom_post_header.dart';
import 'package:flutter_posts_test/app/view/posts/widgets/post_card.dart';

class PostsView extends StatefulWidget {
  const PostsView({super.key});

  @override
  State<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends State<PostsView> {
  late final PostBloc postBloc;
  final scrollController = ScrollController();

  @override
  void initState() {
    postBloc = PostBloc(postRepository: context.read<PostRepository>());
    postBloc.add(PostLoad());
    scrollController.addListener(scrollTrigger);
    super.initState();
  }

  @override
  void dispose() {
    postBloc.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverFloatingHeader(child: CustomPostHeader(onClickImageProfile: onClickImageProfile)),
          BlocBuilder<PostBloc, PostState>(
            bloc: postBloc,
            builder: (context, state) {
              if (state is PostLoading || state is PostInitial) {
                return SliverFillRemaining(child: const Center(child: CustomLoading()));
              }

              if (state is PostFailure) {
                return SliverFillRemaining(
                  child: Center(child: CustomTextError(message: state.message)),
                );
              }

              final posts = (state as PostLoaded).posts;

              if (posts.isEmpty) {
                return SliverFillRemaining(
                  child: const Center(child: Text('Nenhum post encontrado.')),
                );
              } else {
                return buildPostsList(state.posts);
              }
            },
          ),
        ],
      ),
    );
  }

  void onClickImageProfile() {
    Navigator.pushNamed(context, '/userProfile');
  }

  Widget buildPostsList(List<Post> posts) {
    return SliverPadding(
      padding: EdgeInsets.only(top: 4),
      sliver: SliverList.builder(
        itemCount: posts.length + 1,
        itemBuilder: (context, index) {
          if (index == posts.length) return loadMorePostsButton();
          return PostCard(post: posts[index], onTap: onClickPost);
        },
      ),
    );
  }

  // Botão para carregar mais posts.
  // Normalmente o scrollTrigger irá efetuar o carregamento de mais posts, mas se por algum motivo 
  // o scroll não disparar, o usuário pode clicar no botão para carregar mais posts.
  Widget loadMorePostsButton() {
    final state = postBloc.state as PostLoaded;
    if (state.isLastPage) return const SizedBox();

    if (state.onLoadMore) {
      return const Padding(
        padding: EdgeInsets.only(top: 10, bottom: 50),
        child: Center(child: CustomLoading()),
      );
    }

    return TextButton(onPressed: loadMore, child: const Text('Carregar mais'));
  }

  // Dispara o carregamento de mais posts quando o usuário chega ao final da lista
  void scrollTrigger() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      loadMore();
    }
  }

  void loadMore() {
    postBloc.add(PostLoadMore());
  }

  void logout() {
    context.read<WrapperBloc>().add(LogOut());
  }

  void onClickPost(Post post) {
    Navigator.pushNamed(context, '/postDetails', arguments: {'post': post});
  }
}
