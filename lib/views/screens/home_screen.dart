import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:reff/page_view.dart';
import 'package:reff/views/widgets/custom_app_bar.dart';

class HomeScreen extends HookWidget {
  final _logger = Logger("HomeScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomPageView(),
    );
  }
}
