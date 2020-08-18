import 'package:flutter/cupertino.dart';
import 'package:reff_shared/core/models/CityModel.dart';

List<CityModel> getCitiesFromCountry(CountryModel country) {
  final cities = country.cities.map((city) {
    return CityModel(
        countryCode: country.code,
        name: city,
        langCode: country.code,
        utc: country.utc);
  }).toList();

  return cities;
}

CountryModel getCountryFromLocale(BuildContext context) {
  final locale = Localizations.localeOf(context);
  final country = CountryModel.getCountryWithCode(locale?.countryCode);

  return country;
}
