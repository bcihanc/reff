import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/screens/debug_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  hierarchicalLoggingEnabled = true;
  Logger.root.onRecord.listen((record) =>
      print('${record.level.name}: ${record.loggerName}: ${record.message}'));

  await setupLocator();

  runApp(EasyLocalization(
      child: MyApp(),
      supportedLocales: [Locale("tr")],
      path: "assets/translations"));
}

class MyApp extends StatelessWidget {
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
          body: DebugScreen()),
    );
  }
}
