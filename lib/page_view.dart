import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/inner_drawer.dart';
import 'package:reff/views/page_views/archive_pageview.dart';
import 'package:reff/views/page_views/question_pageview.dart';
import 'package:reff/views/page_views/waiting_pageview.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class CustomPageView extends StatefulHookWidget {
  const CustomPageView();

  @override
  _CustomPageViewState createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  PageController _pageController;
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomInnerDrawer(
      scaffold: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (pageIndex) =>
              setState(() => _currentIndex = pageIndex),
          children: [
            WaitingPageView(),
            QuestionPageView(),
            ArchivePageView(),
          ],
        ),
        bottomNavigationBar: TitledBottomNavigationBar(
            currentIndex: _currentIndex,
            activeColor: Theme.of(context).accentColor,
            reverse: true,
            enableShadow: true,
            onTap: (index) {
              _pageController.jumpToPage(index);
              setState(() => _currentIndex = index);
            },
            items: [
              TitledNavigationBarItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text('Oylananlar'),
                  icon: MdiIcons.vote),
              TitledNavigationBarItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text('Gündem'),
                  icon: MdiIcons.rocketLaunch),
              TitledNavigationBarItem(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: Text('Arşiv'),
                  icon: MdiIcons.archive),
            ]),
      ),
    );
  }
}
