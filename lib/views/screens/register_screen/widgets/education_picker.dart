import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff_shared/core/models/models.dart';

class EducationPicker extends HookWidget {
  const EducationPicker();

  @override
  Widget build(BuildContext context) {
    final education =
        useProvider(UserState.provider.state.select((user) => user.education));

    final items = useMemoized(() => Education.values
        .map((education) => DropdownMenuItem<Education>(
              value: education,
              child: Text(tr(education.toString())),
            ))
        .toList());

    return DropdownButton<Education>(
      value: education,
      underline: SizedBox.shrink(),
      items: items,
      onChanged: context.read(UserState.provider).setEducation,
    );
  }
}
