import 'package:flutter/material.dart';
import 'package:reff/core/services/reff_shared_preferences.dart';
import 'package:reff/core/utils/locator.dart';

class DebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final reffSP = getIt<ReffSharedPreferences>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder<String>(
          initialData: "null",
          future: reffSP.getDeviceID(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text("Device ID : ${snapshot.data}");
            }
            return CircularProgressIndicator();
          },
        )
      ],
    );
  }
}
