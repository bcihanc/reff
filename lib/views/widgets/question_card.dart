import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/mock_api.dart';
import 'package:reff/core/utils/locator.dart';

class QuestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final api = locator<MockApi>();

    return FutureBuilder<List<QuestionModel>>(
        future: api.getQuestionsByUserID(user.model.id),
        builder: (context, snapshot) {
          return Column(
            children:
                snapshot.data.map((question) => _cardBuild(context, question)),
          );
        });
  }
}

_cardBuild(BuildContext context, QuestionModel question) {
  return Card(
    child: Column(
      children: <Widget>[
        Text(question.header),
        Wrap(
          children: <Widget>[Text(question.header)],
        )
      ],
    ),
  );
}
