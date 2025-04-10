
import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/view/wrapper.dart';

Route<dynamic>? getRoute(RouteSettings settings) {
  if (settings.name == '/wrapper') {
    return _buildRoute(settings, const Wrapper());
  }
  return null;
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(
    settings: settings,
    builder: (ctx) => builder,
  );
}