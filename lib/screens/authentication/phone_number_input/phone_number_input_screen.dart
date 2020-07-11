import 'package:flutter/material.dart';

import '../../../components/country_code_and_phone_number_widget.dart';
import '../../../my_colors.dart';
import '../otp_input/otp_input_screen.dart';
import '../../../components/help_popup_menu_button.dart';
import 'components/phone_number_helper_text_widget.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  @override
  _PhoneNumberInputScreenState createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  TextEditingController countryController;
  TextEditingController codeController;
  TextEditingController phoneNumberController;

  FocusNode codeFocusNode;
  FocusNode phoneNumberFocusNode;

  @override
  void initState() {
    super.initState();
    countryController = TextEditingController(text: 'Choose a country');
    codeController = TextEditingController();
    phoneNumberController = TextEditingController();

    codeFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
  }

  @override
  void dispose() {
    countryController.dispose();
    codeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  bool validateCodeAndPhoneNumber(BuildContext context) {
    String code = codeController.text;
    String country = countryController.text;
    String phoneNumber = phoneNumberController.text;
    if (code == '') {
      _showDialog('Invalid country code length (1-3 digits only).');
      FocusScope.of(context).requestFocus(codeFocusNode);
    } else if (country == 'invalid country code') {
      _showDialog('invalid code country');
      codeController.text = '';
      FocusScope.of(context).requestFocus(codeFocusNode);
    } else if (phoneNumber == '') {
      _showDialog('Please enter your phone number');
      FocusScope.of(context).requestFocus(phoneNumberFocusNode);
    } else if (phoneNumber.length < 10) {
      _showDialog(
          'The phone number you entered is too short for the country: India.\n\nInclude your area code if you haven\'t.');
      FocusScope.of(context).requestFocus(phoneNumberFocusNode);
    } else {
      return true;
    }
    // if()

    return false;
  }

  void _showDialog(String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 24.0),
          contentPadding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              textColor: MyColors.lightGreen,
              child: Text('ok'.toUpperCase()),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            PhoneNumberHelperTextWidget(),
            SizedBox(height: 12.0),
            CountryCodeAndPhoneNumberWidget(
              size: size,
              countryController: countryController,
              codeController: codeController,
              codeFocusNode: codeFocusNode,
              phoneNumberController: phoneNumberController,
              phoneNumberFocusNode: phoneNumberFocusNode,
            ),
            SizedBox(height: 18.0),
            Text(
              'Carrier SMS Charges may apply',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            ),
            Spacer(),
            FlatButton(
              color: MyColors.lightGreen,
              textColor: Colors.white,
              child: Text('Next'.toUpperCase()),
              onPressed: () {
                bool result = validateCodeAndPhoneNumber(context);
                if (result) {
                  String code = codeController.text;
                  String phoneNumber = phoneNumberController.text;
                  print('+$code $phoneNumber');
                  _showConfirmationDialog('+$code $phoneNumber', context);
                }
              },
            ),
            SizedBox(height: 18.0)
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      leading: Container(),
      title: FittedBox(
        child: Text(
          'Enter you phone number',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: MyColors.lightTealGreen),
        ),
      ),
      actions: <Widget>[
        HelpPopupMenuButton(),
      ],
    );
  }

  void _showConfirmationDialog(String phoneNumber, BuildContext ctx) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 24.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'We will be verifying the phone number: \n\n'),
                    TextSpan(
                        text: phoneNumber,
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(
                        text:
                            '\n\nIs this OK, or would you like to edit the number?'),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      FocusScope.of(ctx).requestFocus(phoneNumberFocusNode);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Edit',
                      style:
                          TextStyle(fontSize: 14.0, color: MyColors.lightGreen),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      if (phoneNumber != null) {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtpInputScreen(
                              phoneNumber: phoneNumber,
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      'OK',
                      style:
                          TextStyle(fontSize: 14.0, color: MyColors.lightGreen),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
