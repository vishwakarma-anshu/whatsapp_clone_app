import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/my_colors.dart';
import 'package:whatsapp_clone_app/screens/authentication_screens/phone_number_input/phone_number_input_screen.dart';
import 'package:whatsapp_clone_app/screens/terms_and_conditions_screen/components/heading_text.dart';
import 'package:whatsapp_clone_app/screens/terms_and_conditions_screen/components/policy_and_terms_text.dart';
import 'package:whatsapp_clone_app/screens/terms_and_conditions_screen/components/whatsapp_clone_logo.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const HeadingText(),
              const SizedBox(height: 36.0),
              WhatsAppCloneLogo(),
              const SizedBox(height: 46.0),
              const PolicyAndTermsText(),
              const SizedBox(height: 16.0),
              RaisedButton(
                elevation: 3.0,
                color: MyColors.lightGreen,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 46.0, vertical: 12.0),
                  child: Text(
                    'Accept and continue'.toUpperCase(),
                    style: TextStyle(color: MyColors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PhoneNumberInputScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 34.0),
              Text(
                'from',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 8.0),
              Text(
                'anshu vishwakarma'.toUpperCase(),
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: MyColors.lightGreen,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
