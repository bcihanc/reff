import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

class SplashScreen extends StatelessWidget {
  final log = Logger("Screens : Splash");
  @override
  Widget build(BuildContext context) {
    log.fine("build");
    return Container();
  }
}
