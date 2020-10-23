import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future_button/future_button.dart';
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

    return Scaffold(
      body: FadeInDown(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(36.0),
              child: Icon(MdiIcons.dramaMasks, size: 96),
            ),
            GenderPicker(),
            const SizedBox(height: 40),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              const Icon(Icons.school, size: 48),
                              EducationPicker()
                            ],
                          ),
                          Column(
                            children: [
                              const Icon(MdiIcons.cakeVariant, size: 48),
                              AgePicker()
                            ],
                          ),
                        ]),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Icon(MdiIcons.earth, size: 48),
                            CountryPicker(
                                initial: countryCodeState.value,
                                countries: CountryModel.countries,
                                onChanged: (country) =>
                                    countryCodeState.value = country)
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(MdiIcons.city, size: 48),
                            CityPicker(cities: countryCodeState.value.cities)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
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
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: FutureRaisedButton(
                color: Theme.of(context).accentColor,
                onPressed: () async {
                  final result =
                      await context.read(UserState.provider).create();
                  if (result) {
                    HomeScreen.show(context);
                  }
                },
                progressIndicatorLocation: ProgressIndicatorLocation.center,
                progressIndicatorBuilder: (_) =>
                    const SpinKitWave(color: Colors.white, size: 32),
                failureIndicatorBuilder: (_) =>
                    const Icon(Icons.error, color: Colors.red),
                disabledColor: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(MdiIcons.guyFawkesMask),
                    const SizedBox(width: 4),
                    const Text('Anonim olarak devam et'),
                    const Icon(Icons.navigate_next)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
