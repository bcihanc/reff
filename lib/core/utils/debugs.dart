import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/inner_drawer.dart';
import 'package:reff/views/screens/splash_screen.dart';
import 'package:reff_shared/core/services/services.dart';

Future<void> deleteUser(BuildContext context) async {
  final deleteResult = await context.read(UserState.provider).deleteUser();
  if (deleteResult) {
    context.read(innerDrawerStateProvider).currentState.close();
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SplashScreen()));
  }
}

Future<void> deleteVotes(BuildContext context) async {
  await locator<BaseVoteApi>()
      .removeAllByUserID(context.read(UserState.provider.state).id);
  // context.read(dataForAnimatedListProvider).clear();
  context.read(innerDrawerStateProvider).currentState.close();
  await Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => SplashScreen()));
}
