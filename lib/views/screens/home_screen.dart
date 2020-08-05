import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff_shared/core/models/models.dart';

class HomeScreen extends StatelessWidget {
  final _logger = Logger("SplashScreen");
  final UserModel user;

  HomeScreen({Key key, this.user})
      : assert(user != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => locator<UserProvider>(param1: user),
      child: Builder(builder: (context) {
        final provider = Provider.of<UserProvider>(context);
        return Center(child: Text(provider.user.id ?? "user id null"));
      }),
    );
  }
}
