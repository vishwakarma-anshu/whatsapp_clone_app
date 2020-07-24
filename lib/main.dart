import 'package:flutter/material.dart';

import 'screens/terms_and_conditions/terms_and_conditions_screen.dart';
import 'utils/export_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.lightTealGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TermsAndConditionsScreen(),
      // home: Test(),
    );
  }
}
