
import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/view/login/login_view.dart';

Route<dynamic>? getRoute(RouteSettings settings) {
  if (settings.name == '/login') {
    return _buildRoute(settings, const LoginView());
  }
  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: (ctx) => builder,
  );
}