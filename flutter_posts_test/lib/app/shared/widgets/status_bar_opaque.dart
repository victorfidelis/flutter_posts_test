import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatusBarOpaque extends StatelessWidget {
  final Widget child;
  final Color statusBarColor;
  final Brightness iconBrightness;

  const StatusBarOpaque({
    super.key,
    required this.child,
    this.statusBarColor = Colors.white,
    this.iconBrightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: iconBrightness,
        systemStatusBarContrastEnforced: true, 
        systemNavigationBarColor: statusBarColor,
        systemNavigationBarContrastEnforced: true,
      ),
      child: child,
    );
  }
}