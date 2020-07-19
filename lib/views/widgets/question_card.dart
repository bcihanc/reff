import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reff/core/providers/question_provider.dart';

class QuestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    return Card(
      child: Column(
        children: <Widget>[Text("")],
      ),
    );
  }
}
