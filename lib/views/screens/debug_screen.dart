import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reff/core/providers/user_provider.dart';

class DebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Device ID : ${user.model?.id?.substring(0, 6)}"),
          Text("Age : ${user.model?.age}"),
          Text("Gender : ${user.model?.gender}"),
          Text("Age : ${user.model?.location}"),
        ],
      ),
    );
  }
}