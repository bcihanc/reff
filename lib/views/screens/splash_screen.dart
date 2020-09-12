import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/screens/register_screen.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

class SplashScreen extends HookWidget {
  final _logger = Logger("SplashScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    return FutureBuilder<Widget>(
      future: _connectionAndUserCheck(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return Scaffold(
            body: Center(
                child: Image.asset(
              "assets/images/logo.png",
              color: Theme.of(context).accentColor,
              height: 100,
            )),
          );
        }
      },
    );
  }
}

Future<UserModel> _tyrToFindUser() async {
  final userID = await locator<ReffSharedPreferences>().getUserID();

  if (userID != null) {
    final user = await locator<BaseUserApi>().get(userID);
    if (user == null) {
      await locator<ReffSharedPreferences>().deleteUserID();
    }
    return user;
  } else {
    debugPrint('isRegistered null');
    return null;
  }
}

Future<Widget> _connectionAndUserCheck(BuildContext context) async {
  await Future.delayed(Duration(seconds: 0));

  final connectivity = await Connectivity().checkConnectivity();

  if (connectivity == ConnectivityResult.none) {
    return Text('no connection');
  } else {
    final userFromFirestore = await _tyrToFindUser();
    if (userFromFirestore != null) {
      context.read(UserState.provider).initializeUser(userFromFirestore);
      return HomeScreen();
    } else {
      return RegisterScreen();
    }
  }
}
