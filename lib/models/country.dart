import 'package:flutter/foundation.dart';

class Country {
  @required
  final String dialingCode;
  @required
  final String name;
  @required
  final String isoCode;
  @required
  final String flagSrc;

  const Country({
    this.dialingCode,
    this.name = "",
    this.isoCode,
    this.flagSrc,
  });

  static const Country IN = const Country(
    name: 'India',
    isoCode: 'IN',
    dialingCode: '91',
    flagSrc: 'assets/images/flags/in_flag.png',
  );
  static const Country US = const Country(
    name: 'United States',
    isoCode: 'US',
    dialingCode: '1',
    flagSrc: 'assets/images/flags/us_flag.png',
  );

  static const Country AT = Country(
    name: "Austria",
    isoCode: "AT",
    dialingCode: "43",
    flagSrc: "assets/flags/at_flag.png",
  );

  static const Country AU = Country(
    name: "Australia",
    isoCode: "AU",
    dialingCode: "61",
    flagSrc: "assets/flags/au_flag.png",
  );

  static const Country BE = Country(
    name: "Belgium",
    isoCode: "BE",
    dialingCode: "32",
    flagSrc: "assets/flags/be_flag.png",
  );

  static const Country BR = Country(
    name: "Brazil",
    isoCode: "BR",
    dialingCode: "55",
    flagSrc: "assets/flags/br_flag.png",
  );

  static const Country CU = Country(
    name: "Cuba",
    isoCode: "CU",
    dialingCode: "53",
    flagSrc: "assets/flags/cu_flag.png",
  );

  static const Country DE = Country(
    flagSrc: "assets/flags/de_flag.png",
    dialingCode: "49",
    isoCode: "DE",
    name: "Germany",
  );

  static const Country ES = Country(
    flagSrc: "assets/flags/es_flag.png",
    dialingCode: "34",
    isoCode: "ES",
    name: "Spain",
  );
}

const List<Country> countries = <Country>[
  Country.IN,
  Country.US,
  Country.AT,
  Country.AU,
  Country.BE,
  Country.BR,
  Country.CU,
  Country.DE,
  Country.ES,
];
