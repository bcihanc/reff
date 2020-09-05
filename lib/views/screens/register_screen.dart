import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:reff/core/providers/main_provider.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/views/screens/gender_selector.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/widgets/privacy_policy_dialog.dart';
import 'package:reff_shared/core/models/CityModel.dart';
import 'package:reff_shared/core/models/models.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class RegisterScreen extends HookWidget {
  final _logger = Logger("RegisterScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");
    final countryCodeState =
        useState(CountryModel.getCountryFromLocale(context));
    final cityState = useState<CityModel>(null);

    final isBusy = useProvider(BusyState.provider.state);

    useEffect(() {
      countryCodeState.value.cities.removeAt(0);
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text('r.e.f.f.', style: GoogleFonts.pacifico()),
        actions: [
          IconButton(
              icon: Icon(MdiIcons.incognito),
              onPressed: () {
                showDialog(context: context, child: PrivacyPolicyDialog());
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          context.read(BusyState.provider).setBusy();
          await context.read(UserState.provider).create();
          context.read(BusyState.provider).setNotBusy();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => (HomeScreen())));
        },
        child: isBusy
            ? CircularProgressIndicator(backgroundColor: Colors.black)
            : Icon(Icons.navigate_next),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                children: [
                  Icon(Icons.person, size: 32),
                  Divider(color: Colors.transparent),
                  GenderSelector(
                    onChanged: (Gender gender) {
                      context.read(UserState.provider).setGender(gender);
                    },
                  ),
                ],
              ),
              Divider(height: 30),
              Column(
                children: [
                  Icon(Icons.cake, size: 32),
                  Divider(color: Colors.transparent),
                  AgePicker(
                    onChanged: (int age) {
                      context.read(UserState.provider).setAge(age);
                    },
                  ),
                ],
              ),
              Divider(height: 30),
              Column(
                children: [
                  Icon(Icons.map, size: 32),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CountryPicker(
                            initialCountry: countryCodeState.value,
                            countries: CountryModel.countries,
                            onChanged: (CountryModel country) {
                              countryCodeState.value = country;
                            }),
                        CityPicker(
                          cities: countryCodeState.value.cities,
                          initialCity:
                              cityState.value ?? countryCodeState.value.capital,
                          onChanged: (CityModel city) {
                            cityState.value = city;
                            context.read(UserState.provider).setLocation(city);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 50, color: Colors.transparent)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CityPicker extends HookWidget {
  CityPicker(
      {@required this.cities,
      @required this.initialCity,
      @required this.onChanged});
  final List<CityModel> cities;
  final CityModel initialCity;
  final ValueChanged<CityModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SearchableDropdown<CityModel>.single(
        underline: '',
        displayClearIcon: false,
        value: initialCity ?? cities.first,
        items: cities
            .map((city) => DropdownMenuItem(
                  child: Text(city.name),
                  value: city,
                ))
            .toList(),
        onChanged: (value) {
          onChanged(value);
        },
      ),
    );
  }
}

class CountryPicker extends HookWidget {
  CountryPicker(
      {@required this.initialCountry,
      @required this.countries,
      @required this.onChanged});
  final List<CountryModel> countries;
  final CountryModel initialCountry;
  final ValueChanged<CountryModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SearchableDropdown<CountryModel>.single(
        underline: '',
        displayClearIcon: false,
        value: this.initialCountry ?? countries.first,
        items: countries
            .map((country) => DropdownMenuItem(
                  child: Text(country.name),
                  value: country,
                ))
            .toList(),
        onChanged: (value) {
          onChanged(value);
        },
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

    return Container(
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
            }));
  }
}
