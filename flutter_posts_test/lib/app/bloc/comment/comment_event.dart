sealed class CommentsEvent {}

class LoadComments extends CommentsEvent {
  final int postId;
  LoadComments(this.postId);
}