import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future_button/future_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:reff/core/providers/user_provider.dart';
import 'package:reff/views/screens/home_screen.dart';
import 'package:reff/views/screens/register_screen/widgets/age_picker.dart';
import 'package:reff/views/screens/register_screen/widgets/city_picker.dart';
import 'package:reff/views/screens/register_screen/widgets/country_picker.dart';
import 'package:reff/views/screens/register_screen/widgets/education_picker.dart';
import 'package:reff/views/screens/register_screen/widgets/gender_selector.dart';
import 'package:reff/views/widgets/privacy_policy_dialog.dart';
import 'package:reff_shared/core/models/CityModel.dart';
import 'package:reff_shared/core/models/models.dart';

class RegisterScreen extends HookWidget {
  final _logger = Logger("RegisterScreen");

  @override
  Widget build(BuildContext context) {
    _logger.info("build");

    final countryCodeState =
        useState(CountryModel.getCountryFromLocale(context));

    final _registerListTiles = [
      ListTile(
        dense: true,
        leading: const Icon(MdiIcons.dramaMasks, size: 30),
        title: const GenderPicker(),
      ),
      Row(
        children: [
          const VerticalDivider(),
          Row(
            children: [
              const Icon(MdiIcons.school, size: 30),
              const VerticalDivider(width: 30),
              const EducationPicker()
            ],
          ),
          const VerticalDivider(width: 45),
          Row(
            children: [
              const Icon(MdiIcons.cakeVariant, size: 30),
              const VerticalDivider(width: 30),
              const AgePicker()
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
                  initial: countryCodeState.value,
                  countries: CountryModel.countries,
                  onChanged: (country) => countryCodeState.value = country),
              const VerticalDivider(width: 70),
              const Icon(MdiIcons.map),
              const VerticalDivider(width: 20),
              CityPicker(cities: countryCodeState.value.cities),
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
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8) +
                            const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).accentColor,
                        ),
                        child: Text(
                          'REFF.',
                          style: GoogleFonts.spartan(
                              letterSpacing: -4,
                              fontSize: 52,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ],
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
                  separatorBuilder: (_, __) => const Divider(),
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
                      builder: (context) => const PrivacyPolicyDialog());
                },
                child: Text(
                  'Gizlilik Sözleşmesi',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      decoration: TextDecoration.underline),
                )),
          ),
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 50,
            child: FutureRaisedButton(
              color: Theme
                  .of(context)
                  .accentColor,
              onPressed: () async {
                final result = await context.read(UserState.provider).create();
                if (result) {
                  HomeScreen.show(context);
                }
              },
              progressIndicatorLocation: ProgressIndicatorLocation.center,
              progressIndicatorBuilder: (_) =>
              const SpinKitWave(color: Colors.white, size: 32),
              failureIndicatorBuilder: (_) =>
              const Icon(Icons.error, color: Colors.red),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(MdiIcons.guyFawkesMask),
                  VerticalDivider(width: 4),
                  const Text('Anonim olarak devam et'),
                  const Icon(Icons.navigate_next)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
