import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/core/utils/logger.dart';
import 'package:reff/views/screens/splash_screen.dart';
import 'package:reff_shared/core/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLogger();
  await setupLocator();

  final api = locator<BaseApi>();
//  await locator<ReffSharedPreferences>().setUserID("TdmoTWNiclrKmOFD6zAC");

  await locator<ReffSharedPreferences>().clear();
  final isRegistered = await locator<ReffSharedPreferences>().isRegistered();

  runApp(EasyLocalization(
      child: MyApp(isRegistered: isRegistered),
      supportedLocales: [Locale("tr")],
      path: "assets/translations"));
}

class MyApp extends StatelessWidget {
  final bool isRegistered;

  const MyApp({Key key, this.isRegistered}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      home: Scaffold(
          appBar: AppBar(
              title: Text(
            tr("title"),
            style: GoogleFonts.pacifico(),
          )),
          body: SplashScreen(
            isRegistered: isRegistered,
          )),
    );
  }
}
