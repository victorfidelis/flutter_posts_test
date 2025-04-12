import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_posts_test/app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const App());
}
