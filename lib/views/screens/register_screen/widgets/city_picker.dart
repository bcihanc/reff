import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class CityPicker extends HookWidget {
  const CityPicker({@required this.cities}) : assert(cities != null);

  final List<CityModel> cities;

  @override
  Widget build(BuildContext context) {
    final city =
        useProvider(UserState.provider.state.select((user) => user.city));

    return SearchableDropdown<CityModel>.single(
        underline: '',
        displayClearIcon: false,
        value: city ?? cities.first,
        items: cities
            .map((city) => DropdownMenuItem(
                  child: Text(city.name),
                  value: city,
                ))
            .toList(),
        onChanged: (city) {
          context.read(UserState.provider).setCity(city);
        });
  }
}
