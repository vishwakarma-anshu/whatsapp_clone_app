import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../components/country_code_and_phone_number_widget.dart';
import '../../../components/help_popup_menu_button.dart';
import '../../../utils/export_utils.dart';
import '../otp_input/otp_input_screen.dart';
import '../profile_info/profile_info_screen.dart';
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
      showCustomDialog(
          'Invalid country code length (1-3 digits only).', context);
      FocusScope.of(context).requestFocus(codeFocusNode);
    } else if (country == 'invalid country code') {
      showCustomDialog('invalid code country', context);
      codeController.text = '';
      FocusScope.of(context).requestFocus(codeFocusNode);
    } else if (phoneNumber == '') {
      showCustomDialog('Please enter your phone number', context);
      FocusScope.of(context).requestFocus(phoneNumberFocusNode);
    } else if (phoneNumber.length < 10) {
      showCustomDialog(
          'The phone number you entered is too short for the country: India.\n\nInclude your area code if you haven\'t.',
          context);
      FocusScope.of(context).requestFocus(phoneNumberFocusNode);
    } else {
      return true;
    }
    // if()

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: buildAppBar(context),
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
                  phoneNumberFocusNode.unfocus();
                  _showConfirmationDialog(code, phoneNumber, context);
                }
              },
            ),
            SizedBox(height: 18.0)
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
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

  void _showConfirmationDialog(
      String countryCode, String phoneNumber, BuildContext ctx) {
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
                        text: '+$countryCode $phoneNumber',
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
                  alertBoxButton(
                    label: 'Edit',
                    onTap: () {
                      FocusScope.of(ctx).requestFocus(phoneNumberFocusNode);
                      Navigator.pop(context);
                    },
                  ),
                  Spacer(),
                  alertBoxButton(
                    label: 'Ok',
                    onTap: () {
                      Navigator.pop(context);
                      verifyPhoneNumber(
                        countryCode: countryCode,
                        phoneNumber: phoneNumber,
                        context: ctx,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  InkWell alertBoxButton({String label, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Text(
          label,
          style: TextStyle(fontSize: 14.0, color: MyColors.lightGreen),
        ),
      ),
    );
  }
}

void verifyPhoneNumber({
  @required String countryCode,
  @required String phoneNumber,
  @required BuildContext context,
}) {
  void verified(AuthCredential credential) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileInfoScreen(
          credential: credential,
          countryCode: countryCode,
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  void failed(AuthException exception) {
    String content = exception.message;
    showCustomDialog(content, context);
  }

  void otpSend(String verificationId, [int forcedSms]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpInputScreen(
          verificationId: verificationId,
          countryCode: countryCode,
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '+$countryCode $phoneNumber',
    timeout: Duration(seconds: 30),
    verificationCompleted: verified,
    verificationFailed: failed,
    codeSent: otpSend,
    codeAutoRetrievalTimeout: null,
  );
}
