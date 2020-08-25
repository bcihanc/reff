import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/core/utils/logger.dart';
import 'package:reff/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  await setupLocator();

//  await locator<ReffSharedPreferences>().clear();

  runApp(ProviderScope(
    child: EasyLocalization(
        child: MyApp(),
        supportedLocales: [Locale("tr")],
        path: "assets/translations"),
  ));
}

class MyApp extends HookWidget {
  final _logger = Logger("MyApp");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'r.e.f.f.',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: Scaffold(body: SplashScreen()),
    );
  }
}
