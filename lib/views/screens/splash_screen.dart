import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/screens/register_screen.dart';
import 'package:reff_shared/core/services/services.dart';

class SplashScreen extends StatelessWidget {
  final _logger = Logger("SplashScreen");
  final bool isRegistered;

  SplashScreen({this.isRegistered});

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    Future.microtask(() => Future.delayed(Duration(seconds: 1)).then((value) {
          if (isRegistered) {
            locator<ReffSharedPreferences>().getUserID().then(
                (userID) => locator<BaseUserApi>().get(userID).then((user) {
                      return Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen(user: user)));
                    }));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          }
        }));

    return Center(child: CircularProgressIndicator());
  }
}
