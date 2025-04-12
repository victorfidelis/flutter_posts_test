
import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/view/post_details/post_details_view.dart';
import 'package:flutter_posts_test/app/view/user_profile/user_profile_view.dart';
import 'package:flutter_posts_test/app/view/wrapper.dart';

Route<dynamic>? getRoute(RouteSettings settings) {
  if (settings.name == '/wrapper') {
    return _buildRoute(settings, const Wrapper());
  }
  if (settings.name == '/postDetails') {
    final args = settings.arguments as Map<String, dynamic>;
    return _buildRoute(settings, PostDetailsView(post: args['post']));
  }
  if (settings.name == '/userProfile') {
    return _buildRoute(settings, UserProfileView());
  }
  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: (ctx) => builder,
  );
}