import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/views/screens/splash_screen.dart';
import 'package:reff/views/widgets/gender_selector.dart';
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
    final cityState = useState<CityModel>(UserModel.initial.city);

    final _registerListTiles = [
      ListTile(
        dense: true,
        leading: Icon(MdiIcons.dramaMasks, size: 30),
        title: GenderSelector(
          initial: UserModel.initial.gender,
          onChanged: (gender) {
            context.read(UserState.provider).setGender(gender);
          },
        ),
      ),
      Row(
        children: [
          VerticalDivider(),
          Row(
            children: [
              Icon(MdiIcons.school, size: 30),
              VerticalDivider(width: 30),
              EducationSelectorWidget(
                initial: UserModel.initial.education,
                onChanged: context.read(UserState.provider).setEducation,
              )
            ],
          ),
          VerticalDivider(width: 45),
          Row(
            children: [
              Icon(MdiIcons.cakeVariant, size: 30),
              VerticalDivider(width: 30),
              AgePicker(
                initial: UserModel.initial.age,
                onChanged: (age) {
                  context.read(UserState.provider).setAge(age);
                },
              )
            ],
          )
        ],
      ),
      ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Icon(MdiIcons.earth, color: Theme.of(context).accentColor),
        ),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CountryPicker(
                  initialCountry: countryCodeState.value,
                  countries: CountryModel.countries,
                  onChanged: (country) {
                    countryCodeState.value = country;
                  }),
              VerticalDivider(width: 70),
              Icon(MdiIcons.map),
              VerticalDivider(width: 20),
              CityPicker(
                cities: countryCodeState.value.cities,
                initial: cityState.value ?? countryCodeState.value.capital,
                onChanged: (city) {
                  cityState.value = city;
                  context.read(UserState.provider).setLocation(city);
                },
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(36.0),
              child: Center(
                child: Hero(
                  tag: "logo",
                  child: Image.asset(
                    "assets/images/logo.png",
                    color: Theme.of(context).accentColor,
                    height: 80,
                    width: 160,
                  ),
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final tile = _registerListTiles[index];
                    return tile;
                  },
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: _registerListTiles.length),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text('Kare Agency Gizlilik Sözleşmesi'),
                                ),
                                Divider(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text("""
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
 Ipsum has been the industry's standard dummy text ever since the 1500s, when an
  unknown printer took a galley of type and scrambled it to make a type specimen
   book. It has survived not only five centuries, but also the leap into 
   electronic typesetting, remaining essentially unchanged. It was popularised 
   in the 1960s with the release of Letraset sheets containing Lorem Ipsum 
   passages, and more recently with desktop publishing software like Aldus 
   PageMaker including versions of Lorem Ipsum, Lorem Ipsum is simply dummy 
   text of the printing and typesetting industry. Lorem Ipsum has been the 
   industry's standard dummy text ever since the 1500s, when an unknown printer 
   took a galley of type and scrambled it to make a type specimen book. It has 
   survived not only five centuries, but also the leap into electronic 
   typesetting, remaining essentially unchanged. It was popularised in the 
   1960s with the release of Letraset sheets containing Lorem Ipsum passages, 
   and more recently with desktop publishing software like Aldus PageMaker 
   including versions of Lorem Ipsum"""),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(8),
                                  child: RaisedButton.icon(
                                      color: Theme.of(context).accentColor,
                                      icon: Icon(MdiIcons.close),
                                      label: Text('Kapat'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                )
                              ]),
                            ),
                          ));
                },
                child: Text(
                  'Gizlilik Sözleşmesi',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      decoration: TextDecoration.underline),
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: RaisedButton.icon(
                icon: Icon(MdiIcons.guyFawkesMask),
                color: Theme.of(context).accentColor,
                label: Row(
                  children: [
                    Text('Anonim olarak devam et'),
                    Icon(Icons.navigate_next)
                  ],
                ),
                onPressed: () async {
                  final result =
                      await context.read(UserState.provider).create();
                  if (result) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => (SplashScreen())));
                  }
                }),
          )
        ],
      ),
    );
  }
}

class CityPicker extends HookWidget {
  CityPicker(
      {@required this.cities,
      @required this.initial,
      @required this.onChanged});

  final List<CityModel> cities;
  final CityModel initial;
  final ValueChanged<CityModel> onChanged;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    final citiesProperty = DiagnosticsProperty("cities", cities);
    final initialProperty = DiagnosticsProperty("initial", initial);

    properties.properties.addAll([citiesProperty, initialProperty]);
    super.debugFillProperties(properties);
  }

  @override
  Widget build(BuildContext context) {
    final cityState = useState(initial);

    return SearchableDropdown<CityModel>.single(
      underline: '',
      displayClearIcon: false,
      value: cityState.value ?? cities.first,
      items: cities
          .map((city) =>
          DropdownMenuItem(
            child: Text(city.name),
            value: city,
          ))
          .toList(),
      onChanged: (city) {
        cityState.value = city;
        onChanged(city);
      },
    );
  }
}

class CountryPicker extends HookWidget {
  CountryPicker({@required this.initialCountry,
    @required this.countries,
    @required this.onChanged});

  final List<CountryModel> countries;
  final CountryModel initialCountry;
  final ValueChanged<CountryModel> onChanged;

  @override
  Widget build(BuildContext context) {
    return SearchableDropdown<CountryModel>.single(
        underline: '',
        displayClearIcon: false,
        value: initialCountry ?? countries.first,
        items: countries
            .map((country) =>
            DropdownMenuItem(
              child: Text(country.name),
              value: country,
            ))
            .toList(),
        onChanged: onChanged);
  }
}

class AgePicker extends HookWidget {
  final int initial;
  final ValueChanged<int> onChanged;

  AgePicker({@required this.initial, this.onChanged}) : assert(initial != null);

  @override
  Widget build(BuildContext context) {
    final _selectedValueState = useState(initial);
    final _ages = List.generate(80, (index) => index + 18);

    return DropdownButton<int>(
        value: _selectedValueState.value,
        underline: SizedBox.shrink(),
        items: _ages
            .map((age) =>
            DropdownMenuItem<int>(value: age, child: Text('$age   ')))
            .toList(),
        onChanged: (age) {
          onChanged(age);
          _selectedValueState.value = age;
        });
  }
}
