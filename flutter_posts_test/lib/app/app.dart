import 'package:flutter/material.dart';
import 'package:flutter_posts_test/app/view/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/login', onGenerateRoute: getRoute);
  }
}
