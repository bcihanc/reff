import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/views/page_views/archive_pageview.dart';
import 'package:reff/views/page_views/question_pageview.dart';
import 'package:reff/views/page_views/waiting_pageview.dart';
import 'package:reff/views/widgets/custom_app_bar.dart';
import 'package:reff/views/widgets/inner_drawer.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class HomeScreen extends StatefulHookWidget {
  static Future<void> show(BuildContext context) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => (HomeScreen())));
  }

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<HomeScreen> {
  PageController _pageController;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _handleFirebaseMessaging();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawerScope(
      scaffold: Scaffold(
        appBar: CustomAppBar(),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageViewOnChanged,
          children: _pages,
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: _currentIndex,
            activeColor: Theme.of(context).accentColor,
            reverse: true,
            enableShadow: true,
            onTap: _handleNavigationBarItemOnTap,
            items: _bottomNavigationItems(context)),
      ),
    );
  }

  Future<void> _handleFirebaseMessaging() async {
    final firebaseMessaging = FirebaseMessaging();

    if (Platform.isIOS) {
      await firebaseMessaging.requestNotificationPermissions();
    }

    await firebaseMessaging.configure();
    final token = await firebaseMessaging.getToken();
    debugPrint("FirebaseMessaging Token: $token");
  }

  final _pages = [WaitingPageView(), QuestionPageView(), ArchivePageView()];
  final _bottomTextStyle = const TextStyle(fontWeight: FontWeight.bold);

  void _handleNavigationBarItemOnTap(int index) {
    _pageController.jumpToPage(index);
    setState(() => _currentIndex = index);
  }

  void _onPageViewOnChanged(int index) {
    setState(() => _currentIndex = index);
  }

  List<TitledNavigationBarItem> _bottomNavigationItems(BuildContext context) =>
      [
        TitledNavigationBarItem(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              'Oylananlar',
              style: _bottomTextStyle,
            ),
            icon: MdiIcons.vote),
        TitledNavigationBarItem(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Gündem', style: _bottomTextStyle),
            icon: MdiIcons.rocketLaunch),
        TitledNavigationBarItem(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text('Arşiv', style: _bottomTextStyle),
            icon: MdiIcons.archive),
      ];
}
