import 'package:flutter_posts_test/app/model/post.dart';

abstract class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> _posts;
  bool onLoadMore;
  int page;

  // Simulação de paginação
  // A cada 10 posts, uma nova página é carregada
  final int quantityPerPage = 10;
  bool get isLastPage => _posts.length <= (page * quantityPerPage);
  int get quantityPosts => isLastPage ? _posts.length : (page * quantityPerPage);
  List<Post> get posts => _posts.sublist(0, quantityPosts);

  // O método nextPage simula o carregamento de uma nova página de posts
  Future<void> nextPage() async {
    if (isLastPage) return;
    await Future.delayed(const Duration(milliseconds: 1200));
    page++;
  }

  PostLoaded({required List<Post> posts, this.page = 1, this.onLoadMore = false}) : _posts = posts;

  PostLoaded copyWith({List<Post>? posts, int? page, bool? onLoadMore}) {
    return PostLoaded(
      posts: posts ?? _posts,
      page: page ?? this.page,
      onLoadMore: onLoadMore ?? this.onLoadMore,
    );
  }
}

class PostFailure extends PostState {
  final String message;
  PostFailure(this.message);
}
