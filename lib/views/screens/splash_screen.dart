import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/services/user_local_api.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/screens/register_screen/register_screen.dart';

class SplashScreen extends HookWidget {
  final _logger = Logger("SplashScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final connectivityFuture = useFuture(
        useMemoized(() => UserLocalApi.connectionAndUserCheck(context)));

    return _handleUserLocalApiState(context, connectivityFuture);
  }

  Widget _handleUserLocalApiState(
      BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      final state = snapshot.data;
      switch (state) {
        case UserLocalApiState.userFound:
          return HomeScreen();
        case UserLocalApiState.userNotFound:
          return RegisterScreen();
        case UserLocalApiState.connectivityProblem:
          return Material(child: Center(child: Text('connection error :/')));
        default:
          return Material(child: Center(child: CircularProgressIndicator()));
      }
    } else if (snapshot.hasError) {
      final error = snapshot.error;
      return Material(
        child: Center(
          child: Text('$error'),
        ),
      );
    } else {
      return Material(
        child: Center(
            child: Image.asset(
          "assets/images/logo.png",
          color: Theme.of(context).accentColor,
          height: 100,
        )),
      );
    }
  }
}
