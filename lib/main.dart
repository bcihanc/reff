import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/core/utils/logger.dart';
import 'package:reff/views/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  setupLogger();
  await setupLocator();

  // await locator<ReffSharedPreferences>().clear();

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
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      theme: ThemeData(
          textTheme: TextTheme(
              headline1: GoogleFonts.ubuntu(fontSize: 16),
              subtitle1: GoogleFonts.ubuntu(fontSize: 12))),
      darkTheme: ThemeData.dark(),
      home: Scaffold(body: SplashScreen()),
      // home: Scaffold(
      //     appBar: AppBar(title: Text('reff')),
      //     bottomNavigationBar:
      //         BottomNavigationBar(backgroundColor: Colors.blue, items: [
      //       BottomNavigationBarItem(
      //           title: Text(
      //             'Arşiv',
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           icon: Icon(Icons.archive, color: Colors.white)),
      //       BottomNavigationBarItem(
      //           title: Text('Gündem'), icon: Icon(Icons.chat)),
      //       BottomNavigationBarItem(
      //           title: Text('Sayılanlar'), icon: Icon(Icons.timelapse))
      //     ]),
      //     body: SafeArea(
      //       child: SingleChildScrollView(
      //         child: Column(
      //           children: [
      //             NewQuestionCard(GradientColors.red),
      //             NewQuestionCard(GradientColors.yellow),
      //           ],
      //         ),
      //       ),
      //     )),
    );
  }
}

class NewQuestionCard extends HookWidget {
  final List<Color> colors;

  NewQuestionCard(this.colors);

  @override
  Widget build(BuildContext context) {
    // final _colorByBrightness =
    //     (MediaQuery.platformBrightnessOf(context) == Brightness.light)
    //         ? Colors.black
    //         : Colors.white;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: colors,
                stops: [0, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and?",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.visible,
              ),
            ),
            Divider(color: Colors.white, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(children: [
                    Icon(MdiIcons.circleOutline, color: Colors.blue),
                    VerticalDivider(),
                    Text('Option A', style: TextStyle(color: Colors.white))
                  ]),
                  Divider(color: Colors.transparent),
                  Row(children: [
                    Icon(MdiIcons.circleOutline, color: Colors.yellow),
                    VerticalDivider(),
                    Text('Option B', style: TextStyle(color: Colors.white))
                  ]),
                  Divider(color: Colors.transparent),
                  Row(children: [
                    Icon(MdiIcons.circleOutline, color: Colors.green),
                    VerticalDivider(),
                    Text('Option C', style: TextStyle(color: Colors.white))
                  ])
                ],
              ),
            ),
            Divider(color: Colors.white, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(MdiIcons.mapMarker, color: Colors.white),
                      VerticalDivider(width: 2),
                      Text("İzmir", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(MdiIcons.timelapse, color: Colors.white),
                      VerticalDivider(width: 2),
                      Text('14 dk kaldı',
                          style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
