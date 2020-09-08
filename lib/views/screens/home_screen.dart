import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:reff/views/widgets/question_list.dart';

class HomeScreen extends HookWidget {
  final _logger = Logger("HomeScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    return QuestionList();
  }
}
