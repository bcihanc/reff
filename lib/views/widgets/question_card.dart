import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

class QuestionCard extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final api = locator<BaseApi>();
    final userProvider = useProvider(userStateProvider.state);
    return FutureBuilder<List<QuestionModel>>(
        future: api.question.getsByUser(userProvider?.id),
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
