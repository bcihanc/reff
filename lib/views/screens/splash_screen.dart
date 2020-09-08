import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/screens/register_screen.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:reff_shared/core/services/services.dart';

// final connectivityFutureProvider = FutureProvider<ConnectivityResult>(
//     (_) => Connectivity().checkConnectivity());

Future<ConnectivityResult> connectivityFuture() async =>
    await Connectivity().checkConnectivity();

Future<UserModel> findUserInSP() async {
  await Future.delayed(Duration(seconds: 0)); // for logo

  final userID = await locator<ReffSharedPreferences>().getUserID();

  return (userID != null)
      ? await locator<BaseUserApi>().get(userID)
      : () {
          debugPrint('isRegistered null');
          return null;
        }();
}

// final sharedPreferencesFutureProvider =
// FutureProvider<UserModel>((ref) async {
//   await Future.delayed(Duration(seconds: 0)); // for logo
//
//   final userID = await locator<ReffSharedPreferences>().getUserID();
//
//   return (userID != null)
//       ? await locator<BaseUserApi>().get(userID)
//       : () {
//           debugPrint('isRegistered null');
//           return null;
//         }();
// });

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _logger = Logger("SplashScreen");
  String message = "Splash Screen";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity != ConnectivityResult.none) {
        final user = await findUserInSP();

        if (user != null) {
          context.read(UserState.provider).initialize(user);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RegisterScreen()));
        }
      } else {
        setState(() => message = "no connection");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    return Center(child: Text('$message'));
  }
}
