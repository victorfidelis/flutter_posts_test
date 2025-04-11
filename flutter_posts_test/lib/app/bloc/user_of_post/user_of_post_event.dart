sealed class UserOfPostEvent {}

class LoadUserOfPost extends UserOfPostEvent {
  final int userId;
  LoadUserOfPost(this.userId);
}