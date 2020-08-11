import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/views/screens/gender_selector.dart';
import 'package:reff_shared/core/models/CityModel.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterScreen extends HookWidget {
  final _logger = Logger("RegisterScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    final userProvider = useProvider(userStateProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await userProvider.create();
        },
        child: Icon(Icons.navigate_next),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GenderSelector(
              onChanged: (Gender gender) {
                userProvider.setGender(gender);
              },
            ),
            Divider(),
            AgePicker(
              onChanged: (int age) {
                userProvider.setAge(age);
              },
            ),
            Divider(),
            LocationPicker(
              onChanged: (CityModel city) {
                userProvider.setLocation(city);
              },
            )
          ],
        ),
      ),
    );
  }
}

class LocationPicker extends HookWidget {
  LocationPicker({this.onChanged});
  final ValueChanged<CityModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          SearchableDropdown.single(
            value: CityModel.initialize,
            items: CityModel.TURKEY
                .map((city) => DropdownMenuItem(
                      child: Text(city.name),
                      value: city,
                    ))
                .toList(),
            onChanged: (value) {
              onChanged(value);
            },
          ),
          Divider(color: Colors.transparent),
          Text('yaşıyorum')
        ],
      ),
    );
  }
}

class AgePicker extends HookWidget {
  final ValueChanged<int> onChanged;

  AgePicker({this.onChanged});

  @override
  Widget build(BuildContext context) {
    final _selectedValueState = useState(32);

    return Column(
      children: [
        Container(
            height: 70,
            child: NumberPicker.horizontal(
                initialValue: _selectedValueState.value,
                haptics: true,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                minValue: 18,
                maxValue: 98,
                onChanged: (value) {
                  _selectedValueState.value = value;
                  onChanged(value.toInt());
                })),
        Divider(color: Colors.transparent),
        Text('yaşındayım'),
      ],
    );
  }
}
