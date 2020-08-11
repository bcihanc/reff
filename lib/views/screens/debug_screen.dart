import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reff/core/providers/user_provider.dart';

class DebugScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = useProvider(userStateProvider.state);

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Device ID : ${userProvider?.id?.substring(0, 6)}"),
          Text("Age : ${userProvider?.age}"),
          Text("Gender : ${userProvider?.gender}"),
          Text("Age : ${userProvider?.city?.name}"),
        ],
      ),
    );
  }
}
