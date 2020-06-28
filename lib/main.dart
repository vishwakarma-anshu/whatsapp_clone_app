import 'package:flutter/material.dart';

import 'my_colors.dart';
import 'screens/terms_and_conditions/terms_and_conditions_screen.dart';

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
    );
  }
}
