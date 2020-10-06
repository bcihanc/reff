import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/main_provider.dart';
import 'package:reff/views/widgets/inner_drawer.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    final isBusy = useProvider(BusyState.provider.state);

    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      brightness: Theme.of(context).brightness,
      title: Hero(
        tag: "logo",
        child: Image.asset(
          "assets/images/logo.png",
          // color: isDarkMode ? Colors.white : Colors.grey,
          color: Theme.of(context).accentColor,
          height: kToolbarHeight * 0.5,
        ),
      ),
      leading: SizedBox.shrink(),
      // geri butonu gizlemek için
      flexibleSpace: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                        icon: Icon(MdiIcons.bug, color: Colors.red),
                        onPressed: () {
                          context
                              .read(innerDrawerStateProvider)
                              .currentState
                              .toggle(direction: InnerDrawerDirection.start);
                        }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        icon: Icon(
                          MdiIcons.dockRight,
                        ),
                        onPressed: () {
                          context
                              .read(innerDrawerStateProvider)
                              .currentState
                              .toggle(direction: InnerDrawerDirection.end);
                        }),
                  ),
                ],
              ),
            ),
          ),
          isBusy ? LinearProgressIndicator() : SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
