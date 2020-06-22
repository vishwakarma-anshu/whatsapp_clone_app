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
    flagSrc: 'assets/images/flags/in-flag.png',
  );
  static const Country US = const Country(
    name: 'United States',
    isoCode: 'US',
    dialingCode: '1',
    flagSrc: 'assets/images/flags/us_flag.png',
  );

  static const ALL = <Country>[
    IN,
    US,
  ];
}
