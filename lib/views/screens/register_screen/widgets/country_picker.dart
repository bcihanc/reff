import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class CountryPicker extends HookWidget {
  const CountryPicker(
      {@required this.initial, @required this.countries, this.onChanged})
      : assert(initial != null),
        assert(countries != null);

  final List<CountryModel> countries;
  final CountryModel initial;
  final ValueChanged<CountryModel> onChanged;

  @override
  Widget build(BuildContext context) {
    final countryState = useState(initial);

    return SearchableDropdown<CountryModel>.single(
        underline: '',
        displayClearIcon: false,
        value: countryState.value ?? countries.first,
        items: countries
            .map((country) => DropdownMenuItem(
                  child: Text(country.name),
                  value: country,
                ))
            .toList(),
        onChanged: (country) {
          onChanged(country);
          countryState.value = country;
        });
  }
}
