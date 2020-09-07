import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:state_notifier/state_notifier.dart';

final mainAppBarProvider = StateNotifierProvider((ref) => MainAppBarState());

class MainAppBarState extends StateNotifier<AppBar> {
  MainAppBarState()
      : super(AppBar(
            primary: true,
            actions: [
              IconButton(icon: Icon(MdiIcons.incognito), onPressed: () {})
            ],
            title: Text(tr("title"), style: GoogleFonts.pacifico())));

  void loadHomeAppBar() {
    state = AppBar(
        primary: true, title: Text(tr("title"), style: GoogleFonts.pacifico()));
  }
}
