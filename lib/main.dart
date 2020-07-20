import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reff/core/models/UserModel.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/core/services/mock_api.dart';
import 'package:reff/core/utils/locator.dart';
import 'package:reff/core/utils/logger.dart';
import 'package:reff/core/utils/mock_data.dart' as mock;
import 'package:reff/views/screens/debug_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  logger();
  await setupLocator();

  final userID = await () async {
    await Future.delayed(Duration(seconds: 1));
    return mock.userCollectionMock.first["id"];
  }();

  final api = locator<MockApi>();
  final user = await () async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
        id: mock.kuserID1, age: 29, gender: Gender.MALE, location: "antalya");
  }();

  runApp(EasyLocalization(
      child: MultiProvider(providers: [
        ChangeNotifierProvider<UserProvider>(
            create: (context) =>
                locator<UserProvider>(param1: user, param2: api)),
      ], child: MyApp()),
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
