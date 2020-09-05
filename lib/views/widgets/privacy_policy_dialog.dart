import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PrivacyPolicyDialog extends HookWidget {
  const PrivacyPolicyDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(child: Text('gizlilik bildirimi')),
    );
  }
}
