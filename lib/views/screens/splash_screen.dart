import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/screens/register_screen.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

final userFutureProvider = FutureProvider<UserModel>((_) async {
  await Future.delayed(Duration(seconds: 0)); // for logo

  final userID = await locator<ReffSharedPreferences>().getUserID();

  if (userID != null) {
    return await locator<BaseUserApi>().get(userID);
  } else {
    debugPrint('isRegistered null');
    return null;
  }

  return (userID != null) ? await locator<BaseUserApi>().get(userID) : null;
});

class SplashScreen extends HookWidget {
  final _logger = Logger("SplashScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final registerState = useProvider(userFutureProvider);

    return registerState.when(
        data: (user) =>
            (user != null) ? HomeScreen(user: user) : RegisterScreen(),
        loading: () => Center(child: Text('logo')),
        error: (err, stack) => Center(child: Text("$err")));
  }
}
