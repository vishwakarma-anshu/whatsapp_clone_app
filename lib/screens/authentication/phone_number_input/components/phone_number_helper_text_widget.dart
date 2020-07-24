import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../utils/export_utils.dart';

class PhoneNumberHelperTextWidget extends StatefulWidget {
  const PhoneNumberHelperTextWidget({
    Key key,
  }) : super(key: key);

  @override
  _PhoneNumberHelperTextWidgetState createState() =>
      _PhoneNumberHelperTextWidgetState();
}

class _PhoneNumberHelperTextWidgetState
    extends State<PhoneNumberHelperTextWidget> {
  TapGestureRecognizer _tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        showToastMessage(
            'Unable to get phone number from SIM. Please type in your phone number.');
      };
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
          ),
          text:
              'WhatsApp clone wil send an SMS message to verify your phone number. ',
          children: <TextSpan>[
            TextSpan(
              text: 'What\'s my number ?',
              style: TextStyle(color: MyColors.lightSkyBlue),
              recognizer: _tapGestureRecognizer,
            ),
          ],
        ),
      ),
    );
  }
}
