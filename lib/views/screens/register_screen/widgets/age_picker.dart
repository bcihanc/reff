import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:reff/core/providers/user_provider.dart';

class AgePicker extends HookWidget {
  const AgePicker();

  @override
  Widget build(BuildContext context) {
    final age =
        useProvider(UserState.provider.state.select((user) => user.age));

    final agesDropdownList = useMemoized(() {
      final ages = List.generate(80, (index) => index + 18);
      return ages
          .map((age) =>
              DropdownMenuItem<int>(value: age, child: Text('$age   ')))
          .toList();
    });

    return DropdownButton<int>(
        value: age,
        underline: SizedBox.shrink(),
        items: agesDropdownList,
        onChanged: context.read(UserState.provider).setAge);
  }
}
