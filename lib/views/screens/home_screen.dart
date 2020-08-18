import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/views/widgets/question_card.dart';
import 'package:reff_shared/core/models/models.dart';

class HomeScreen extends HookWidget {
  final _logger = Logger("HomeScreen");
  final UserModel user;

  HomeScreen({Key key, this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final userProvider = useProvider(userStateProvider);

    useMemoized(() async {
      userProvider.initialize(user);
    });

    return QuestionCard();
    return Center(
        child: Column(
      children: [
        Text(userProvider.user.id ?? "user id null"),
        Text(userProvider.user.age.toString() ?? "user id null"),
        Text(userProvider.user.gender.toString() ?? "user id null"),
        Text(userProvider.user.city.name ?? "user id null"),
      ],
    ));
  }
}
