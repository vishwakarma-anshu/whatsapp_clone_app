import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/components/countries.dart';

class CountryDropdown extends StatefulWidget {
  CountryDropdown({
    Key key,
  }) : super(key: key);

  @override
  _CountryDropdownState createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  List<DropdownMenuItem> countries = Country.ALL
      .map<DropdownMenuItem<String>>((Country country) => DropdownMenuItem(
          value: country.name,
          child: Text(
            country.name,
            textAlign: TextAlign.center,
          )))
      .toList();

  Country selectedCountry = Country.IN;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCountry.name,
      items: countries,
      onChanged: (String value) {
        Country _country = Country
            .ALL[Country.ALL.indexWhere((country) => country.name == value)];

        setState(() => selectedCountry = _country);
      },
    );
  }
}
