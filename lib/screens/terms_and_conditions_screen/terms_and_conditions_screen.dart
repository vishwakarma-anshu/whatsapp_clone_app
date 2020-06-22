import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/my_colors.dart';
import 'package:whatsapp_clone_app/screens/authentication_screens/phone_number_input/phone_number_input_screen.dart';
import 'package:whatsapp_clone_app/screens/terms_and_conditions_screen/components/heading_text.dart';
import 'package:whatsapp_clone_app/screens/terms_and_conditions_screen/components/policy_and_terms_text.dart';
import 'package:whatsapp_clone_app/screens/terms_and_conditions_screen/components/whatsapp_clone_logo.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            HeadingText(),
            WhatsAppCloneLogo(),
            PolicyAndTermsText(),
            RaisedButton(
              elevation: 3.0,
              color: MyColors.lightGreen,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 9.5),
                child: Text(
                  'Agree and continue'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white, fontSize: 12.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => PhoneNumberInputScreen(),
                  ),
                );
              },
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'from\n',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                    text: 'anshu vishwakarma'.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: MyColors.lightGreen,
                          fontSize: 18.0,
                          letterSpacing: 2.0,
                          height: 2.0,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
