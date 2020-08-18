import 'package:connectivity/connectivity.dart';
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

final connectivityStreamProvider = FutureProvider<ConnectivityResult>(
    (_) => Connectivity().checkConnectivity());

final userFutureProvider = FutureProvider<UserModel>((_) async {
  await Future.delayed(Duration(seconds: 0)); // for logo

  final userID = await locator<ReffSharedPreferences>().getUserID();

  return (userID != null)
      ? await locator<BaseUserApi>().get(userID)
      : () {
          debugPrint('isRegistered null');
          return null;
        }();
});

class SplashScreen extends HookWidget {
  final _logger = Logger("SplashScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final registerState = useProvider(userFutureProvider);
    final connectivityStream = useProvider(connectivityStreamProvider);

    return registerState.when(
        data: (data) =>
            (data != null) ? HomeScreen(user: data) : RegisterScreen(),
        loading: () => Container(color: Colors.blue),
        error: (err, stack) => Center(child: Container(color: Colors.red)));
  }
}

class ConnectionErrorWidget extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Connection need :/'));
  }
}
