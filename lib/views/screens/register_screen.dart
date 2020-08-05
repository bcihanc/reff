import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:reff/views/screens/gender_selector.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterScreen extends StatelessWidget {
  final _logger = Logger("RegisterScreen");

  RegisterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GenderSelector(),
            Divider(),
            AgePicker(),
            LocationPicker()
          ],
        ),
      ),
    );
  }
}

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  TurkeyCities city;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown.single(
      icon: Icon(Icons.map),
      value: city,
      items: [
        DropdownMenuItem(
          child: Text('Antalya'),
          value: TurkeyCities.ANTALYA,
        ),
        DropdownMenuItem(child: Text('İstanbul'), value: TurkeyCities.ISTANBUL),
      ],
      onChanged: (value) {
        setState(() {
          this.city = value;
        });
      },
    );
  }
}

enum TurkeyCities { ISTANBUL, ANTALYA }

class AgePicker extends StatefulWidget {
  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  int _selectedValue = 32;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: Theme(
        data: ThemeData.dark().copyWith(accentColor: Colors.grey),
        child: Builder(
            builder: (context) => NumberPicker.horizontal(
                initialValue: _selectedValue,
                haptics: true,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Theme.of(context).accentColor),
                ),
                minValue: 18,
                maxValue: 98,
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                })),
      ),
    );
  }
}
